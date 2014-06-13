#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.setup
require 'nokogiri'
require 'open-uri'
require_relative 'init'
require_relative 'facebook'

facebook = Facebook.new :chrome

begin
  # Login
  facebook.login
  facebook.goto_saga_directory
  day_links = facebook.collect_days
  puts facebook.collect_sagas(day_links)

ensure
  facebook.close
end
