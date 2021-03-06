#############################################
# build script (ruby make) for football.db
#
#  use:
#   $ rake   or
#   $ rake build     - to build football.db from scratch
#
#   $ rake -T        - show all tasks


require_relative 'boot'

###
# csv repos
FOOTBALLCSV_DIR = '../../footballcsv'

CSV_DATASETS = {
  fr: { path: "#{FOOTBALLCSV_DIR}/france" },
}


################
# club country repos

DATASETS = {
  at:       { path: "#{OPENFOOTBALL_DIR}/austria" }, ## domestic clubs
  de:       { path: "#{OPENFOOTBALL_DIR}/deutschland" },
  en:       { path: "#{OPENFOOTBALL_DIR}/england" },
  es:       { path: "#{OPENFOOTBALL_DIR}/espana" },
  it:       { path: "#{OPENFOOTBALL_DIR}/italy" },
  fr:       { path: "#{OPENFOOTBALL_DIR}/france" },

  cl:       { path: "#{OPENFOOTBALL_DIR}/europe-champions-league" },  ## int'l clubs

  worldcup: { path: "#{OPENFOOTBALL_DIR}/world-cup" },  ## national teams
  euro:     { path: "#{OPENFOOTBALL_DIR}/euro-cup" },

  world:    { path: "#{OPENFOOTBALL_DIR}/world" },
}


## event keys for standings table in README updates
DATASETS[:at][:events] = [
  ['at.1.2012/13'],
  ['at.1.2013/14'],
  ['at.1.2014/15', 'at.2.2014/15'],
  ['at.1.2015/16', 'at.2.2015/16'],
  ['at.1.2016/17', 'at.2.2016/17'],
  ['at.1.2017/18', 'at.2.2017/18'],
  ['at.1.2018/19', 'at.2.2018/19'],
  ['at.1.2019/20', 'at.2.2019/20'],
]

DATASETS[:de][:events] = [
  ['de.1.2012/13'],
  ['de.1.2013/14', 'de.2.2013/14'],
  ['de.1.2014/15', 'de.2.2014/15'],
  ['de.1.2015/16', 'de.2.2015/16', 'de.3.2015/16'],
  ['de.1.2016/17', 'de.2.2016/17', 'de.3.2016/17'],
  ['de.1.2017/18', 'de.2.2017/18', 'de.3.2017/18'],
  ['de.1.2018/19', 'de.2.2018/19'],
  ['de.1.2019/20', 'de.2.2019/20', 'de.3.2019/20']
]

DATASETS[:en][:events] = [
   'eng.1.2012/13',
   'eng.1.2013/14',
   'eng.1.2014/15',
   'eng.1.2015/16',
   'eng.1.2016/17',
   'eng.1.2017/18',
   'eng.1.2018/19',
   'eng.1.2019/20',
]

DATASETS[:es][:events] = [
  'es.1.2012/13',
  'es.1.2013/14',
  'es.1.2014/15',
  'es.1.2015/16',
  'es.1.2016/17',
  'es.1.2017/18',
  'es.1.2018/19',
  'es.1.2019/20',
]

DATASETS[:it][:events] = [
  'it.1.2013/14',
  'it.1.2014/15',
  'it.1.2015/16',
  'it.1.2016/17',
  'it.1.2017/18',
  'it.1.2018/19',
  'it.1.2019/20',
]

DATASETS[:fr][:events] = [
  ['fr.1.2014/15', 'fr.2.2014/15'],
]



## champions league mods
##   todo/fix: move to sportdb lib - why? why not?
DATASETS[:cl][:mods] = {
  'Arsenal   | Arsenal FC'    => 'Arsenal, ENG',
  'Liverpool | Liverpool FC'  => 'Liverpool, ENG',
  'Barcelona'                 => 'Barcelona, ESP',
  'Valencia'                  => 'Valencia, ESP'
}



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
  logger.warn "hello build - #{Time.now}"  # say hello; log to db (warn level min)

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

DATASETS.each do |key,h|
  task :"read_#{key}" => :config do
    SportDb.read( h[:path] )
  end
end

## note: :ru not working for now (fix date e.g. [])
task :read_all => DATASETS.keys.map {|key|:"read_#{key}" } do
end

CSV_DATASETS.each do |key,h|
  task :"read_#{key}_csv" => :config do
    SportDb.read_csv( h[:path] )
  end
end



desc 'build football.db from scratch (default)'
task :build => [:clean, :create, :"read_#{DATA_KEY}"] do
  puts 'Done.'
end



################
# stats

require_relative 'scripts/stats_i'
require_relative 'scripts/stats_ii'


task :stats => :"stats_#{DATA_KEY}" do
end

DATASETS.each do |key,h|
  task :"stats_#{key}" => :config do

      out_root = if debug?
                  "#{BUILD_DIR}/#{File.basename( h[:path] )}"
                 else
                  "#{h[:path]}/.build"
                 end

      ## make sure parent folders exist
      FileUtils.mkdir_p( out_root ) unless Dir.exist?( out_root )

      File.open( "#{out_root}/stats.txt", 'w:utf-8' ) do |f|
        f.write "# Stats\n"
        f.write "\n"
        f.write build_stats
        f.write "\n\n"
        f.write "## Logs\n"
        f.write "\n"
        f.write build_logs
      end

      File.open( "#{out_root}/leagues.txt", 'w:utf-8' ) do |f|
        f.write "# Leagues\n"
        f.write "\n"
        f.write build_leagues    ## ( ['de.1', 'de.2', 'de.3', 'de.cup'] )
      end

      File.open( "#{out_root}/clubs.txt", 'w:utf-8' ) do |f|
        f.write "# Clubs\n"
        f.write "\n"
        f.write build_teams_by_leagues   ## ( ['de.1', 'de.2', 'de.3', 'de.cup'] )
      end
  end
end



################
# lint

def print_errors( errors )
  if errors.size > 0
    puts "#{errors.size} error(s) / warn(s):"
    errors.each do |error|
      puts "!! ERROR: #{error}"
    end
  else
    puts "#{errors.size} errors / warns"
  end
end


task :lint => :"lint_#{DATA_KEY}" do
end

DATASETS.each do |key,h|
  task :"lint_#{key}"do
    start_time = Time.now   ## todo: use Timer? t = Timer.start / stop / diff etc. - why? why not?
    buf, errors = SportDb::PackageLinter.lint( h[:path],
                                               mods: h[:mods] )
## was:  SportDb::PackageLinter.lint( h[:path],
#            lang: h[:lang],
#            exclude: /archive/,
#            mods: h[:mods] )

    print_errors( errors )

    end_time = Time.now
    diff_time = end_time - start_time
    puts "lint_#{key}: done in #{diff_time} sec(s)"


    out_root = if debug?
                 "#{BUILD_DIR}/#{File.basename( h[:path] )}"
               else
                 "#{h[:path]}/.build"
               end

    ## make sure parent folders exist
    FileUtils.mkdir_p( out_root ) unless Dir.exist?( out_root )

    File.open( "#{out_root}/lint.txt" , 'w:utf-8' ) do |f|
      f.write( buf )
    end
  end
end


################
# recalcs

require_relative 'scripts/standings'
require_relative 'scripts/results'


# note: use rake recalc DATA=de     and NOT recalc_de (always requires DATA/DATA_KEY to be set!!)
task :recalc => :"recalc_#{DATA_KEY}" do
end

DATASETS.each do |key,h|
  task :"recalc_#{key}" => :config do
    out_root = if debug?
                 "#{BUILD_DIR}/#{File.basename( h[:path] )}"
               else
                 "#{h[:path]}"
               end

    (h[:events]||[]).each do |event_keys|
      recalc_standings( event_keys, out_root: out_root )
      ## recalc_stats( out_root: out_root )
    end
  end
end



###
# logs

desc 'print logs (stored in db)'
task :logs => :env do
  puts "db logs (#{LogDb::Models::Log.count})"
  LogDb::Models::Log.order(:id).each do |log|
     puts "  [#{log.level}] #{log.ts}  - #{log.msg}"
  end
end



############################
## commit and push all dataset repos!!!!

task :push => :"push_#{DATA_KEY}" do
end

DATASETS.each do |key,h|
  task :"push_#{key}" do
    ## todo/fix:
    ##  check if any changes (only push if changes commits - how??)

    puts "Dir.getwd: #{Dir.getwd}"
    Dir.chdir( h[:path] ) do
      ## trying to update
      puts ''
      puts "###########################################"
      puts "## trying to commit and push >#{key}< in #{h[:path]}"
      puts "Dir.getwd: #{Dir.getwd}"
      result = system( "git status" )
      pp result
      result = system( "git add ." )
      pp result
      result = system( %Q{git commit -m "up build"} )
      pp result
      result = system( "git push" )
      pp result
      ## todo: check return code
    end
    puts "Dir.getwd: #{Dir.getwd}"
  end
end

task :push_all => DATASETS.keys.map {|key|:"push_#{key}" } do
end
