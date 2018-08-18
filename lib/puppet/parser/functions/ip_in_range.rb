module Puppet::Parser::Functions
  require 'ipaddr'

  newfunction(:ip_in_range, type: :rvalue, arity: 2, doc:
    "ip_in_range returns true if the ipaddress is within the given CIDRs
    usage: ip_in_range(<IPv4 Address>, <IPv4 CIDR>)

    $valid_ip = ip_in_range('10.10.10.53', '10.10.10.0/24') # $valid_ip == true

    or you can pass an array of CIDR ranges and return true if the IP is inside
    any of them.

    $ranges = ['192.168.0.0/24', '10.10.10.0/24']
    $valid_ip = ip_in_range('10.10.10.53', $ranges) # $valid_ip == true

    # or use it in a conditional

    if ip_in_range($ipaddress, '10.10.200.0/24') == true {
      notify { 'Do subnet based resources here': }
    }

    ") do |args|

    unless args.length == 2
      raise ArgumentError, "ip_in_range(): wrong number of arguments (#{args.length} must be 2)"
    end

    # load in the ip validation function from puppetlabs-stdlib
    unless Puppet::Parser::Functions.function('is_ip_address')
      raise Puppet::ParseError, 'ip_in_range(): requires the puppetlabs-stdlib functions'
    end

    # 2nd arg can be an array so normalise it into one array for processing
    args.flatten!

    # error out if any of the args given are not valid IP addresses
    args.each do |ipaddress|
      unless function_is_ip_address([ipaddress])
        error = 'is an invalid ip address'
        raise ArgumentError, "ip_in_range(): [#{ipaddress}] #{error}"
      end
    end

    # Now we're done with the boilerplate do the actual check

    begin
      ip = IPAddr.new(args.shift)
      # anything that isn't the IP is a range to compare it against
      ranges = args.map { |r| IPAddr.new(r) }
    rescue ArgumentError => e
      raise ArgumentError, "ip_in_range(): #{e}"
    end

    # return true if any of the ranges contain the IP address
    ranges.any? { |range| range.include?(ip) }
  end
end
