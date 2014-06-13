#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.setup
require 'nokogiri'
require 'open-uri'
require_relative 'init'
require_relative 'facebook'

facebook = Facebook.new

begin
  # Login
  facebook.login

  # Collect daily saga links
  day_links = facebook.collect_days

  # Go to each daily saga and group sagas by authors
  sagas = facebook.collect_sagas(day_links)

  sagas.each_pair do |author, ss|
    puts "\n** #{author}'s Mini-Saga Collection **\n"
    ss.sort.map do |day, s| #sorts by days
      puts "\nDay #{day}:"
      puts s
    end
  end
ensure
  facebook.close
end
