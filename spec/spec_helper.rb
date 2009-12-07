begin
  require 'spec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'reverse_geocoder'


Spec::Runner.configure do |config|
  
  def stub_httparty_response(response_object, code)
    HTTParty::Response.new(response_object, '', code, 'OK')
  end

end