require 'spec_helper'

describe 'ip_in_range' do
  # Basic functionality tests
  #################################################
  it 'should return true when the ip is contained in the range' do
    should run.with_params('192.168.100.12', '192.168.100.0/24').and_return(true)
  end

  it 'should return true when the ip is contained in an array of ranges' do
    ranges = ['10.10.10.10/24', '192.168.100.0/24']
    should run.with_params('192.168.100.12', ranges).and_return(true)
  end

  it 'should return false when an ip is not in the range' do
    should run.with_params('10.10.10.10', '192.168.100.0/24').and_return(false)
  end

  # Invalid function call tests
  #################################################
  it 'should throw an ArgumentError unless called with 2 arguments' do
    is_expected.to run.with_params().and_raise_error(ArgumentError, /Wrong number/)
  end

  it 'should throw an ArgumentError with an invalid ip address' do
    is_expected.to run.with_params('300.2.3.4', '192.168.100.0/24').and_raise_error(ArgumentError, /invalid ip address/)
  end

  it 'Should throw an ArgumentError with an invalid CIDR range' do
    is_expected.to run.with_params('192.168.100.12', '192.168.100.0/242').and_raise_error(ArgumentError, /invalid ip address/)
  end
end
