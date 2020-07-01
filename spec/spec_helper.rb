require 'rspec-puppet'

RSpec.configure do |config|
  config.mock_with :rspec
end

require 'puppetlabs_spec_helper/puppet_spec_helper'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
end
