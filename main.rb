#!/usr/bin/ruby

# Starter script for WishList
require 'pp'
require 'rubygems'
#gem 'ramaze', '2008.06'
require 'ramaze'

require 'controller'
require 'ramaze/store/default'
WishList = Ramaze::Store::Default.new "wishlist.yaml"
{ 0 => {:item => "New Cellphone", :user => 'colin', :rating => 5},
  1 => {:item => "New Computer", :user => 'thomas', :rating => 5},
}.each do |id, tags|
  WishList[id] = tags
end

Ramaze::Log.loggers.each{|l| l.log_levels << :dev }

Ramaze.start :adapter => :mongrel, :port => 8093
