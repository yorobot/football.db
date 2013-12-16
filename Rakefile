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

WORLD_INCLUDE_PATH = "#{OPENMUNDI_ROOT}/world.db"


WORLD_CUP_INCLUDE_PATH = "#{OPENFOOTBALL_ROOT}/world-cup"



DB_CONFIG = {
  adapter:    'sqlite3',
  database:   FOOTBALL_DB_PATH
}


#######################
#  print settings

settings = <<EOS
*****************
settings:
  WORLD_INCLUDE_PATH: #{WORLD_INCLUDE_PATH}

  WORLD_CUP_INCLUDE_PATH: #{WORLD_CUP_INCLUDE_PATH}
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
  WorldDb.read_setup( 'setups/sport.db.admin', WORLD_INCLUDE_PATH, skip_tags: true )
  # WorldDb.stats
end


task :importsport => :env do
  SportDb.read_builtin
  
  LogUtils::Logger.root.level = :debug

  SportDb.read_setup( 'setups/all', WORLD_CUP_INCLUDE_PATH )
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
