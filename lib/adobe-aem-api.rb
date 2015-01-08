require 'ostruct'
require 'net/http'
require 'json'
require 'recursive-open-struct'
require 'nokogiri'
require 'net/http/post/multipart'

self_dir = File.dirname(__FILE__)
Dir["#{self_dir}/**/*.rb"].each do |lib|
  require File.expand_path(lib)
end
