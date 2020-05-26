#############################################
# build script (ruby make) for football.db
#
#  use:
#   $ rake   or
#   $ rake build     - to build football.db from scratch
#
#   $ rake -T        - show all tasks


$RUBYLIBS_DEBUG = true


SPORTDB_DIR      = '../../sportdb'     # path to libs

## note: use the local version of sportdb gems
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-formats/lib" ))

# $LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/football.db/footballdb-leagues/lib" ))
# $LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/football.db/footballdb-clubs/lib" ))

$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-config/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-models/lib" ))


# 3rd party libs/gems
require 'sportdb/readers'



OPENFOOTBALL_DIR = "../../openfootball"

################
# club country repos
AT_DIR  = "#{OPENFOOTBALL_DIR}/austria"
DE_DIR  = "#{OPENFOOTBALL_DIR}/deutschland"
EN_DIR  = "#{OPENFOOTBALL_DIR}/england"
ES_DIR  = "#{OPENFOOTBALL_DIR}/espana"
IT_DIR  = "#{OPENFOOTBALL_DIR}/italy"




BUILD_DIR = "./build"


## note: use DATA/DATASET key for db name too
##   - one db per repo - for easy stats etc.

DATA_KEY = ENV['DATA'] || ENV['DATASET'] || 'all'     ## note: was 'worldcup' default DATA_KEY
puts "  using DATA_KEY >#{DATA_KEY}<"

DB_CONFIG = {
  adapter:   'sqlite3',
  database:  "#{BUILD_DIR}/#{DATA_KEY}.db"
}

# note:
#   uses (configured) for SQLite in-memory database
#      e.g. there's no BUILD_DIR (and database on the file system)
#
# DB_CONFIG = {
#   adapter:  'sqlite3',
#   database: ':memory:'
# }

#  load database config from external file (easier to configure/change)
#   note: use symbolize_keys if you load config via YAML.load !!!!
#
# DB_HASH   = YAML.load( ERB.new( File.read( './database.yml' )).result )
# DB_CONFIG = DB_HASH[ 'default' ].symbolize_keys    ## for now just always use default section/entry


def debug?
  value = ENV['DEBUG']
  if value && ['true', 't', 'yes', 'y'].include?( value.downcase )
    true
  else
    false
  end
end


task :default => :build


task :clean do
  ### for sqlite3 delete/remove single-file database
  if DB_CONFIG[ :adapter ]  == 'sqlite3'
    database = DB_CONFIG[ :database ]

    rm database  if database != ':memory:' && File.exist?( database )
  end
end


directory BUILD_DIR

task :env => BUILD_DIR do
  SportDb.connect( DB_CONFIG )
end



task :config  => :env  do
  logger = LogUtils::Logger.root

  ## log all warns, errors, fatals to db
  LogDb.setup
  logger.warn "Rakefile - #{Time.now}"  # say hello; log to db (warn level min)

  ## use DEBUG=t or DEBUG=f
  logger.level = if debug?
                   :debug
                 else
                   :info
                 end
end


task :create => :env do
  SportDb.create_all
end


#########################################################
# note: change deps to what you want to import for now

##
# default to all (if no key given)
#
# e.g. use like
#  $ rake build  DATA=all  or
#  $ rake build  DATA=en
#  etc.

task :read_at => :config do
  SportDb.read( AT_DIR )
end

task :read_de => :config do
  SportDb.read( DE_DIR )
end

task :read_en => :config do
  SportDb.read( EN_DIR )
end

task :read_es => :config do
  SportDb.read( ES_DIR )
end

task :read_it => :config do
  SportDb.read( IT_DIR )
end


## note: :ru not working for now (fix date e.g. [])
task :read_all => [:read_at,
                   :read_de,
                   :read_en,
                   :read_es,
                   :read_it] do
end



desc 'build football.db from scratch (default)'
task :build => [:clean, :create, :"read_#{DATA_KEY}"] do
  puts 'Done.'
end




################
# recalcs

require_relative 'scripts/standings'
require_relative 'scripts/results'


# note: use rake recalc DATA=de     and NOT recalc_de (always requires DATA/DATA_KEY to be set!!)
task :recalc => :"recalc_#{DATA_KEY}" do
end


task :recalc_de => :config do
  out_root = if debug?
               "#{BUILD_DIR}/deutschland"
             else
               DE_DIR
             end

  [['de.1.2012/13'],
   ['de.1.2013/14', 'de.2.2013/14'],
   ['de.1.2014/15', 'de.2.2014/15'],
   ['de.1.2015/16', 'de.2.2015/16', 'de.3.2015/16'],
   ['de.1.2016/17', 'de.2.2016/17', 'de.3.2016/17'],
   ['de.1.2017/18', 'de.2.2017/18', 'de.3.2017/18'],
   ['de.1.2018/19', 'de.2.2018/19'],
   ['de.1.2019/20', 'de.2.2019/20', 'de.3.2019/20']].each do |event_keys|
  recalc_standings( event_keys, out_root: out_root )
     ## recalc_stats( out_root: out_root )
  end
end



task :recalc_en => :config do
  out_root = if debug?
    "#{BUILD_DIR}/england"
  else
    EN_DIR
  end

  ['eng.1.2012/13',
   'eng.1.2013/14',
   'eng.1.2014/15',
   'eng.1.2015/16',
   'eng.1.2016/17',
   'eng.1.2017/18',
   'eng.1.2018/19',
   'eng.1.2019/20',
  ].each do |event_key|
     recalc_standings( event_key, out_root: out_root )
     ## recalc_stats( out_root: out_root )
  end
end
