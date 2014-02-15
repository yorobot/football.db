# encoding: utf-8

# world book build script
#
#  run from book folder e.g. issue:
#   $ ruby _scripts/build.rb


# -- ruby std libs

require 'erb'

# -- 3rd party gems

require 'worlddb'   ### NB: for local testing use rake -I ./lib dev:test e.g. do NOT forget to add -I ./lib
require 'sportdb'
require 'logutils/db'


# -- custom code

require_relative 'helpers/link'
require_relative 'helpers/markdown'
require_relative 'helpers/navbar'
require_relative 'helpers/part'
require_relative 'helpers/misc'
require_relative 'helpers/city'
require_relative 'helpers/ground'
require_relative 'helpers/team'
require_relative 'helpers/page'


require_relative 'filters'
require_relative 'utils'
require_relative 'pages'
require_relative 'book'




puts 'Welcome'



puts "Dir.pwd: #{Dir.pwd}"

# --  db config
FOOTBALL_DB_PATH = "../build/build/football.db"


LogUtils::Logger.root.level = :info

DB_CONFIG = {
  adapter:    'sqlite3',
  database:   FOOTBALL_DB_PATH
}

pp DB_CONFIG
ActiveRecord::Base.establish_connection( DB_CONFIG )


WorldDb.tables
SportDb.tables


### model shortcuts

Continent = WorldDb::Model::Continent
Country   = WorldDb::Model::Country
Region    = WorldDb::Model::Region
City      = WorldDb::Model::City

Team      = SportDb::Model::Team
League    = SportDb::Model::League
Event     = SportDb::Model::Event
Game      = SportDb::Model::Game
Ground    = SportDb::Model::Ground



build_book()                # multi-page version
build_book( inline: true )  # all-in-one-page version a.k.a. inline version


puts 'Done. Bye.'