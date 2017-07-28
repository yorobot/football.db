# encoding: utf-8

#
# use to run:
#  $ ruby test/env.rb


require 'pp'
require 'date'     ##  Date.today


auto_dir = "/auto"
auto_dir = File.expand_path( auto_dir )
pp auto_dir

pp File.expand_path( '/src' )
pp File.expand_path( '/Sites' )
pp File.expand_path( '..' )
pp File.expand_path( '../..' )


##
## note: on windows expands to
##   /auto  =>   C:/auto
