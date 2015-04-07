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


$RUBYLIBS_DEBUG = true

# 3rd party libs/gems
require 'worlddb'   ## todo/check: just require worlddb/models - why, why not??
require 'sportdb'   ## todo/check: just require sportdb/models - why, why not??
require 'logutils/activerecord' ## add db logging


BUILD_DIR = "./build"


# our own code
require './settings'
require './scripts/stats'
require './scripts/standings'



## load database config from external file (easier to configure/change)
DB_HASH   = YAML.load( ERB.new( File.read( './database.yml' )).result ) 
DB_CONFIG = DB_HASH[ 'default' ]    ## for now just always use default section/entry



task :default => :build

directory BUILD_DIR


task :clean do
  db_adapter = DB_CONFIG[ 'adapter' ]
  ### for sqlite3 delete/remove single-file database
  if db_adapter == 'sqlite3'
     db_database =  DB_CONFIG[ 'database' ]
     rm db_database if File.exists?( db_database )
  else
    puts "  clean: do nothing; no clean steps configured for db adapter >#{db_adapter}<"
  end
end


task :env => BUILD_DIR do
  pp DB_CONFIG
  ActiveRecord::Base.establish_connection( DB_CONFIG )

  db_adapter = DB_CONFIG[ 'adapter' ]
  if db_adapter == 'sqlite3'
    ## try to speed up sqlite
    ## see http://www.sqlite.org/pragma.html
    c = ActiveRecord::Base.connection
    c.execute( 'PRAGMA synchronous=OFF;' )
    c.execute( 'PRAGMA journal_mode=OFF;' )
    c.execute( 'PRAGMA temp_store=MEMORY;' )
  end
end


task :config  => :env  do
  logger = LogUtils::Logger.root
  # logger.level = :info

  ## log all warns, errors, fatals to db
  LogDb.setup
  logger.warn "Rakefile - #{Time.now}"  # say hello; log to db (warn level min)  
end

task :configworld => :config do
  logger = LogUtils::Logger.root
  logger.level = :info
end

task :configsport => :config do
  logger = LogUtils::Logger.root

  ## try first
  ### use DEBUG=t or DEBUG=f
  ### or alternative LOG|LOGLEVEL=debug|info|warn|error

  debug_key = ENV['DEBUG']
  if debug_key.nil?
    ## try log_key as "fallback"
    ##  - env variable that lets you configure log level
    log_key = ENV['LOG'] || ENV['LOGLEVEL'] || 'debug'
    puts "  using LOGLEVEL >#{log_key}<"
    logger.level = log_key.to_sym
  else
    if ['true', 't', 'yes', 'y'].include?( debug_key.downcase )
      logger.level = :debug
    else
      logger.level = :info
    end
  end
end


task :create => :env do
  SportDb.create_all
end


task :importworld => :configworld do
  # populate world tables
  #  use countries only for now (faster)
  WorldDb.read_setup( 'setups/countries', WORLD_DB_INCLUDE_PATH, skip_tags: true )
  ### WorldDb.read_setup( 'setups/sport.db.admin', WORLD_DB_INCLUDE_PATH, skip_tags: true )
end


task :importbuiltin => :env do
  SportDb.read_builtin
end

############################################
# add more tasks (keep build script modular)

Dir.glob('./tasks/**/*.rake').each do |r|
  puts "  importing task >#{r}<..."
  import r
  # see blog.smartlogicsolutions.com/2009/05/26/including-external-rake-files-in-your-projects-rakefile-keep-your-rake-tasks-organized/
end




task :world => :importbuiltin do
  SportDb.read_setup( 'setups/teams',   CLUBS_INCLUDE_PATH )
end


task :europe_clubs => :importbuiltin do
  SportDb.read_setup( 'setups/teams',  CLUBS_INCLUDE_PATH )   ## use teams_europe ??
  SportDb.read_setup( 'setups/all',    AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    IT_INCLUDE_PATH )
end


#########################################################
# note: change deps to what you want to import for now

##
# default to worldcup (if no key given)
#
# e.g. use like
#  $ rake update DATA=admin  or
#  $ rake build  DATA=all
#  etc.


DATA_KEY = ENV['DATA'] || ENV['DATASET'] || ENV['FX'] || ENV['FIXTURES'] || 'worldcup'
puts "  using DATA_KEY >#{DATA_KEY}<"

task :importsport => [:configsport, DATA_KEY.to_sym] do
  # nothing here
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


# desc 'pull (auto-update) football.db from upstream sources'
# task :pull => :env do
#  SportDb.update!
#  puts 'Done.'
# end
