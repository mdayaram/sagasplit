#!/usr/bin/env ruby

require 'rubygems'
require 'watir-webdriver'
require 'watir-webdriver/wait'
require 'yaml'

config = {}
begin
  config_path = File.join(File.dirname(__FILE__), "config", "config.yml")
  config = YAML.load_file(config_path)
rescue Exception => e
  puts "Failed to parse config/config.yml file.  Does it exist?"
  puts e.inspect
  exit 1
end

USERNAME = config["user"]
PASSWORD = config["pass"]
DIRECTORY_URL = config["directory_link"]
CLOSE_BROWSER = config["close_browser_on_exit"]
