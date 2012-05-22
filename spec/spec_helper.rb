require 'puppet'
require 'rubygems'
require 'rspec-puppet'
require 'mocha'

def param_value(subject, type, title, param)
  subject.resource(type, title).send(:parameters)[param.to_sym]
end

def verify_contents(subject, title, expected_lines)
  content = subject.resource('file', title).send(:parameters)[:content]
  (content.split("\n") & expected_lines).should == expected_lines
end

RSpec.configure do |c|
  c.mock_with :mocha
  c.manifest_dir = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures/manifests'))
  c.module_path = File.join(File.dirname(__FILE__), 'fixtures/modules')
end
