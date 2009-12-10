require 'rubygems'

gem 'httparty', '>= 0.4.5'
require 'httparty'

dir = Pathname(__FILE__).dirname.expand_path
require "#{dir}/reverse_geocoder/version"
require "#{dir}/reverse_geocoder/exceptions"
require "#{dir}/reverse_geocoder/geocoder"
require "#{dir}/reverse_geocoder/google"
require "#{dir}/reverse_geocoder/geonames"
require "#{dir}/reverse_geocoder/geoplugin"
require "#{dir}/reverse_geocoder/ibegin"
require "#{dir}/reverse_geocoder/numerex"
require "#{dir}/reverse_geocoder/geoapi"
require "#{dir}/reverse_geocoder/multi"