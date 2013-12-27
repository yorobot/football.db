#######################################
# build script (Ruby make)
#
#  use:
#   $ rake   or
#   $ rake build     - to build football.db from scratch
#
#   $ rake update    - to update football.db
#
#   $ rake -T        - show all tasks


BUILD_DIR = "./build"

# -- output db config
FOOTBALL_DB_PATH = "#{BUILD_DIR}/football.db"


# -- input repo sources config
OPENMUNDI_ROOT = "../../openmundi"
OPENFOOTBALL_ROOT = ".."

WORLD_DB_INCLUDE_PATH = "#{OPENMUNDI_ROOT}/world.db"


WORLD_CUP_INCLUDE_PATH   = "#{OPENFOOTBALL_ROOT}/world-cup"
EURO_CUP_INCLUDE_PATH    = "#{OPENFOOTBALL_ROOT}/euro-cup"
AFRICA_CUP_INCLUDE_PATH  = "#{OPENFOOTBALL_ROOT}/africa-cup"
AMERICA_CUP_INCLUDE_PATH = "#{OPENFOOTBALL_ROOT}/america-cup"

WORLD_INCLUDE_PATH       = "#{OPENFOOTBALL_ROOT}/world"
DE_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/de-deutschland"
EN_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/en-england"
ES_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/es-espana"
MX_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/mx-mexico"
BR_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/br-brazil"



DB_CONFIG = {
  adapter:    'sqlite3',
  database:   FOOTBALL_DB_PATH
}


#######################
#  print settings

settings = <<EOS
*****************
settings:
  WORLD_DB_INCLUDE_PATH: #{WORLD_DB_INCLUDE_PATH}

  WORLD_CUP_INCLUDE_PATH:    #{WORLD_CUP_INCLUDE_PATH}
  EURO_CUP_INCLUDE_PATH:     #{EURO_CUP_INCLUDE_PATH}
  AFRICA_CUP_INCLUDE_PATH:   #{AFRICA_CUP_INCLUDE_PATH}
  AMERICA_CUP_INCLUDE_PATH:  #{AMERICA_CUP_INCLUDE_PATH}

  WORLD_INCLUDE_PATH:        #{WORLD_INCLUDE_PATH}
  DE_INCLUDE_PATH:           #{DE_INCLUDE_PATH}
  EN_INCLUDE_PATH:           #{EN_INCLUDE_PATH}
  ES_INCLUDE_PATH:           #{ES_INCLUDE_PATH}
  MX_INCLUDE_PATH:           #{MX_INCLUDE_PATH}
  BR_INCLUDE_PATH:           #{BR_INCLUDE_PATH}
*****************
EOS

puts settings




task :default => :build

directory BUILD_DIR


task :clean do
  rm FOOTBALL_DB_PATH if File.exists?( FOOTBALL_DB_PATH )
end


task :env => BUILD_DIR do
  require 'worlddb'   ### NB: for local testing use rake -I ./lib dev:test e.g. do NOT forget to add -I ./lib
  require 'sportdb'
  require 'logutils/db'

  LogUtils::Logger.root.level = :info

  pp DB_CONFIG
  ActiveRecord::Base.establish_connection( DB_CONFIG )
end

task :create => :env do
  LogDb.create
  WorldDb.create
  SportDb.create
end

task :importworld => :env do
  # populate world tables
  WorldDb.read_setup( 'setups/sport.db.admin', WORLD_DB_INCLUDE_PATH, skip_tags: true )
  # WorldDb.stats
end

task :importbuiltin => :env do
  SportDb.read_builtin
  LogUtils::Logger.root.level = :debug
end


task :worldcup => :importbuiltin do
  SportDb.read_setup( 'setups/teams', EURO_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', AFRICA_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', AMERICA_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',   WORLD_CUP_INCLUDE_PATH )
end

task :es => :importbuiltin do
  SportDb.read_setup( 'setups/all',   ES_INCLUDE_PATH )
end

task :world => :importbuiltin do
  SportDb.read_setup( 'setups/teams', EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', MX_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', BR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',   WORLD_INCLUDE_PATH )
end


#########################################################
# note: change deps to what you want to import for now

task :importsport => [:world] do
  # SportDb.stats
end

task :deletesport => :env do
  SportDb.delete!
end


desc 'build football.db from scratch (default)'
task :build => [:clean, :create, :importworld, :importsport] do
  puts 'Done.'
end

desc 'update football.db'
task :update => [:deletesport, :importsport] do
  puts 'Done.'
end

desc 'pull (auto-update) football.db from upstream sources'
task :pull => :env do
  SportDb.update!
  puts 'Done.'
end


task :about do
  # todo: print versions of gems etc.
end
