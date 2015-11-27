puppet-ip_in_range
==================

A Puppet function to determine if an IPv4 address is within the IPv4 CIDR

ip_in_range returns true if the ipaddress is within the CIDR

    usage: ip_in_range(<IPv4 Address>, <IPv4 CIDR>)

There are a couple of commonly used patterns -

    $valid_ip = ip_in_range('10.10.10.53', '10.10.10.0/24') # $valid_ip == true

or using the check as part of a conditional -

    if ip_in_range($ipaddress, '10.10.200.0/24') == true {
      notify { 'Do subnet based resources here': }
    }

It has a dependency on puppetlabs-stdlib to work.

### License ###

Apache 2.0 - [Dean Wilson](http://www.unixdaemon.net)
