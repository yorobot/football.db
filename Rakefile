#############################################
# build script (ruby make) for football.db
#
#  use:
#   $ rake   or
#   $ rake build     - to build football.db from scratch
#
#   $ rake update    - to update football.db
#
#   $ rake -T        - show all tasks


$RUBYLIBS_DEBUG = true


require 'json'

# 3rd party libs/gems
require 'worlddb/models'   ## todo/check: just require worlddb/models - why, why not??
require 'sportdb/models'   ## todo/check: just require sportdb/models - why, why not??
require 'logutils/activerecord' ## add db logging




BUILD_DIR = "./build"


# our own code
require './settings'
require './scripts/stats'
require './scripts/standings'

# our own code
require './scripts/up/rake'

require './scripts/up/logs'
require './scripts/up/standings'
require './scripts/up/stats'
require './scripts/up/team'

require './scripts/up/sport'
require './scripts/up/json'




# note:
#   uses (configured) for SQLite in-memory database
#      e.g. there's no BUILD_DIR (and database on the file system)
#

# DB_CONFIG = {
#   'adapter'  => 'sqlite3',
#   'database' => ':memory:'
# }

###
# for testing/debuggin change to file
#   note: use string keys (not symbols!!! e.g. 'adapter' NOT adapter: etc.)

DB_CONFIG = {
  'adapter'  =>  'sqlite3',
  'database' =>  './build/sport.db'
}



## load database config from external file (easier to configure/change)
## DB_HASH   = YAML.load( ERB.new( File.read( './database.yml' )).result )
## DB_CONFIG = DB_HASH[ 'default' ]    ## for now just always use default section/entry



task :default => :build

directory BUILD_DIR


task :clean do
  db_adapter  = DB_CONFIG[ 'adapter' ]
  db_database = DB_CONFIG[ 'database' ]

  ### for sqlite3 delete/remove single-file database
  if db_adapter == 'sqlite3' && db_database != ':memory:'
     db_database =  DB_CONFIG[ 'database' ]
     rm db_database if File.exists?( db_database )
  else
    puts "  clean: do nothing; no clean steps configured for db adapter >#{db_adapter}<"
  end
end



task :env => BUILD_DIR do
  pp DB_CONFIG
  ActiveRecord::Base.establish_connection( DB_CONFIG )

  db_adapter  = DB_CONFIG[ 'adapter' ]
  db_database = DB_CONFIG[ 'database' ]

  if db_adapter == 'sqlite3' && db_database != ':memory:'
    puts "*** sqlite3 database on filesystem; try speedup..."
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

load_tasks()   ## e.g. see scripts/rake.rb -- (auto-)imports ./tasks/**/*.rake





#########################################################
# note: change deps to what you want to import for now

##
# default to worldcup (if no key given)
#
# e.g. use like
#  $ rake update DATA=admin  or
#  $ rake build  DATA=all
#  $ rake build  DATA=en
#  etc.


DATA_KEY = ENV['DATA'] || ENV['DATASET'] || 'all'     ## note: was 'worldcup' default DATA_KEY
puts "  using DATA_KEY >#{DATA_KEY}<"

task :importsport => [:configsport, DATA_KEY.to_sym] do
  # nothing here
end


###
## from "new" update build script

## note: :ru not working for now (fix date e.g. [])
task :all => [:at,:de,:en,:es,:it] do
end


task :recalc => ["recalc_#{DATA_KEY}".to_sym] do    ## e.g. recalc_at etc.
  # nothing here
end

## note: :ru not working for now (fix date e.g. [])
task :recalc_all => [:recalc_at,:recalc_de,:recalc_en,:recalc_es,:recalc_it] do
end


task :stats => :env  do
  puts build_stats
  puts 'Done.'
end

task :logs => :env do
  out_root = debug? ? './build' : '../logs/football.db'   ## todo: use const for ../logs ???

  save_logs( out_root: out_root )
  puts 'Done.'
end




desc 'build football.db from scratch (default)'
## task :build => [:clean, :create, :importworld, :importsport] do
task :build => [:create, :importworld, :importsport] do    ## note: removed :clean target for now - add back!!
  puts 'Done.'
end



task :deletesport => :env do
  SportDb.delete!
end

desc 'update football.db'
task :update => [:deletesport, :importsport] do
  puts 'Done.'
end




=begin
#### auto-add tasks via datafiles
require './scripts/builder'

datafiles = collect_datafiles()
datafiles.each do |datafile|
  task_name = datafile.name.to_sym
  task_deps = datafile.deps.each {|dep| dep.to_sym }

  puts "adding task '#{datafile.name}' => #{datafile.deps.inspect}:"
  puts "  #{datafile.datasets.size} datasets, #{datafile.scripts.size} scripts"

  desc "datafile #{task_name} (auto-task: #{datafile.datasets.size} datasets, #{datafile.scripts.size} scripts)"
  task task_name => task_deps do
    datafile.dump
    # skip for now  -- step 1: download
    datafile.read   # step 2: read in all datasets
    datafile.calc   # step 3: run all calc(ulations) scripts
  end

  task "debug_#{task_name}" do
    puts ''
    puts "=== debug: task #{task_name} depends on #{task_deps.inspect}:"
    puts "  #{datafile.datasets.size} datasets, #{datafile.scripts.size} scripts"
    puts ''
    datafile.dump
  end

end
=end
