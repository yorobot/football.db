#######################################
# build script (Ruby make)
#
#  use:
#   $ rake   or
#   $ rake build     - to build sport.db from scratch
#
#   $ rake update    - to update sport.db
#
#   $ rake -T        - show all tasks


BUILD_DIR = "./build"


####
# fix: use FOOTBALL_DB_PATH or FT_DB_PATH

# -- output db config
SPORT_DB_PATH = "#{BUILD_DIR}/football.db"

# -- input repo sources config
#
# use world_db_repo path or
#    world_db_fx path or similar ??
#  use world_include_path

WORLD_DB_INCLUDE_PATH = '../../openmundi/world.db'

### rename to WORLD_CUP_INCLUDE_PATH
SPORT_DB_INCLUDE_PATH = '../world-cup'   # todo: make it into an array


DB_CONFIG = {
  adapter:    'sqlite3',
  database:   SPORT_DB_PATH
}


#######################
#  print settings

settings = <<EOS
*****************
settings:
  WORLD_DB_INCLUDE_PATH: #{WORLD_DB_INCLUDE_PATH}
  SPORT_DB_INCLUDE_PATH: #{SPORT_DB_INCLUDE_PATH}
*****************
EOS

puts settings




task :default => :build

directory BUILD_DIR


task :clean do
  rm SPORT_DB_PATH if File.exists?( SPORT_DB_PATH )
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
  WorldDb.read_setup( 'setups/sport.db.admin', WORLD_DB_INCLUDE_PATH, skip_tags: true )  # populate world tables
  # WorldDb.stats
end


task :importsport => :env do
  SportDb.read_builtin
  SportDb.read_setup( 'setups/all', SPORT_DB_INCLUDE_PATH )
  # SportDb.stats
end

task :deletesport => :env do
  SportDb.delete!
end


desc 'build sport.db from scratch (default)'
task :build => [:clean, :create, :importworld, :importsport] do
  puts 'Done.'
end

desc 'update sport.db'
task :update => [:deletesport, :importsport] do
  puts 'Done.'
end

desc 'pull (auto-update) sport.db from upstream sources'
task :pull => :env do
  SportDb.update!
  puts 'Done.'
end


task :about do
  # todo: print versions of gems etc.
end