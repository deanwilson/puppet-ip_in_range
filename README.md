puppet-ip_in_range
==================

[![Build Status](https://travis-ci.org/deanwilson/puppet-ip_in_range.svg?branch=master)](https://travis-ci.org/deanwilson/puppet-ip_in_range)
[![Puppet Forge](https://img.shields.io/puppetforge/v/deanwilson/ip_in_range.svg)](https://forge.puppetlabs.com/deanwilson/ip_in_range)

A Puppet function to determine if an IPv4 address is within the IPv4 CIDR

`ip_in_range` returns true if the ipaddress is within the given CIDRs

    usage: ip_in_range(<IPv4 Address>, <IPv4 CIDR>)

or when you want to check against more than one CIDR and return
true if the IP address is contained in any of them.

    $ranges = ['192.168.0.0/24', '10.10.10.0/24']
    $valid_ip = ip_in_range('10.10.10.53', $ranges) # $valid_ip == true

There are a couple of commonly used patterns -

    $valid_ip = ip_in_range('10.10.10.53', '10.10.10.0/24') # $valid_ip == true

or using the check as part of a conditional -

    if ip_in_range($ipaddress, '10.10.200.0/24') == true {
      notify { 'Do subnet based resources here': }
    }

It has a dependency on puppetlabs-stdlib to work.

## Installation

You can install this module from [PuppetForge](https://forge.puppet.com/):

    puppet module install deanwilson-ip_in_range

### License ###

Apache 2.0 - [Dean Wilson](http://www.unixdaemon.net)
