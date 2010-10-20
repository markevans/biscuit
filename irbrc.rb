require 'rubygems'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'biscuit'
require 'logger'
ActiveRecord::Base.logger = Logger.new(STDOUT)
include Biscuit
Biscuit.connect!
puts "Required Biscuit"
