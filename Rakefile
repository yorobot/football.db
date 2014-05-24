
puts "before require 'sportdb'"
require 'sportdb'  
puts "after require 'sportdb'"


#######################################
# build script (Ruby make)
#
#  use:
#   $ rake   or
#   $ rake build     - to build football.db from scratch
#
#   $ rake update    - to update football.db
#
#   $ rake book    - build book
#
#   $ rake -T        - show all tasks


BUILD_DIR = "./build"

# -- output db config
FOOTBALL_DB_PATH = "#{BUILD_DIR}/football.db"


require './settings'


DB_CONFIG = {
  adapter:    'sqlite3',
  database:   FOOTBALL_DB_PATH
}


task :default => :build

directory BUILD_DIR


task :clean do
  rm FOOTBALL_DB_PATH if File.exists?( FOOTBALL_DB_PATH )
end



task :env => BUILD_DIR do
  logger = LogUtils::Logger.root
  logger.level = :info

  pp DB_CONFIG
  ActiveRecord::Base.establish_connection( DB_CONFIG )
  
  ## log all warns, errors, fatals to db
  LogDb.setup
  logger.warn "Rakefile - #{Time.now}"  # say hello; log to db (warn level min)  
end


task :create => :env do
  LogDb.create
  ConfDb.create
  TagDb.create
  WorldDb.create
  PersonDb.create
  SportDb.create
end


task :importworld => :env do
  # populate world tables
  WorldDb.read_setup( 'setups/sport.db.admin', WORLD_DB_INCLUDE_PATH, skip_tags: true )
end

task :importbuiltin => :env do
  SportDb.read_builtin

  logger = LogUtils::Logger.root
  logger.level = :debug
end

######################
# grounds / stadiums

task :grounds  => :importbuiltin do
  SportDb.read_setup( 'setups/all',   STADIUMS_INCLUDE_PATH )
end

#######################
# players

task :players  => :importbuiltin do
  SportDb.read_setup( 'setups/all',   PLAYERS_INCLUDE_PATH )
end

task :squads => :players do
  ## test/try squads for worldcup 2014
  ## add importbuiltin dep too (or reuse from players) ?? why? why not??

  SportDb.read_setup( 'setups/all',          NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014_squads',  WORLD_CUP_INCLUDE_PATH )
end


#####################
# national teams


task :history => :importbuiltin do
  SportDb.read_setup( 'setups/all',     NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/history', NATIONAL_TEAMS_INCLUDE_PATH )
  
  SportDb.read_setup( 'setups/history', WORLD_CUP_INCLUDE_PATH )
end

task :worldcup => :importbuiltin do
  SportDb.read_setup( 'setups/all',   NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',   WORLD_CUP_INCLUDE_PATH )
end

task :worldcup2014 => :importbuiltin do
  SportDb.read_setup( 'setups/all',          NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014_quali',   WORLD_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014',         WORLD_CUP_INCLUDE_PATH )
end

task :worldcup2014q => :importbuiltin do
  SportDb.read_setup( 'setups/all',          NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014_quali',   WORLD_CUP_INCLUDE_PATH )
end


task :copaamerica => :importbuiltin do
  SportDb.read_setup( 'setups/all',   NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',   COPA_AMERICA_INCLUDE_PATH )
end

task :goldcup  => :importbuiltin do
  SportDb.read_setup( 'setups/all', NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', NORTH_AMERICA_GOLD_CUP_INCLUDE_PATH )
end

task :eurocup  => :importbuiltin do
  SportDb.read_setup( 'setups/all', NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', EURO_CUP_INCLUDE_PATH )
end


################################
# football clubs n leagues

task :cl201314  => :importbuiltin do
  SportDb.read_setup( 'setups/teams',    WORLD_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',    AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',    DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',    EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',    ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',    IT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH )
end

task :es => :importbuiltin do
  SportDb.read_setup( 'setups/all',   ES_INCLUDE_PATH )
end

task :clubs => :importbuiltin do
  ## todo/fix: add es,it,at too!!!
  SportDb.read_setup( 'setups/teams', EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', MX_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', BR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',   WORLD_INCLUDE_PATH )
end

task :world => :importbuiltin do
  SportDb.read_setup( 'setups/teams',   WORLD_INCLUDE_PATH )
end

## fix: use official short codes/shortcuts e.g. america_cl?
task :northamericachampionsleague => :importbuiltin do
  SportDb.read_setup( 'setups/teams', MX_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', WORLD_INCLUDE_PATH )   # use teams_north_america, central_america, caribbean ??
  SportDb.read_setup( 'setups/all',   NORTH_AMERICA_CHAMPIONS_LEAGUE_INCLUDE_PATH )
end

task :copalibertadores => :importbuiltin do
  SportDb.read_setup( 'setups/teams', MX_INCLUDE_PATH )  # include invitees (mx teams)
  SportDb.read_setup( 'setups/teams', BR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', WORLD_INCLUDE_PATH )  # use teams_south_america ??
  SportDb.read_setup( 'setups/all',   COPA_LIBERTADORES_INCLUDE_PATH )
end

task :copasudamericana => :importbuiltin do
  SportDb.read_setup( 'setups/teams', MX_INCLUDE_PATH )  # include invitees (mx teams) ???
  SportDb.read_setup( 'setups/teams', BR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', WORLD_INCLUDE_PATH )  # use teams_south_america ??
  SportDb.read_setup( 'setups/all',   COPA_SUDAMERICANA_INCLUDE_PATH )
end


task :europe_clubs => :importbuiltin do
  SportDb.read_setup( 'setups/teams',  WORLD_INCLUDE_PATH )   ## use teams_europe ??
  SportDb.read_setup( 'setups/all',    AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    IT_INCLUDE_PATH )
end


#############
# Misc

task :all => [:importbuiltin, :grounds] do
  ########
  # national teams

  SportDb.read_setup( 'setups/all', NATIONAL_TEAMS_INCLUDE_PATH )

  SportDb.read_setup( 'setups/all', EURO_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', AFRICA_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', NORTH_AMERICA_GOLD_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', COPA_AMERICA_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', WORLD_CUP_INCLUDE_PATH )

  ################
  # clubs

  SportDb.read_setup( 'setups/teams',  WORLD_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',  AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',  DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',  EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',  ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',  IT_INCLUDE_PATH )

  SportDb.read_setup( 'setups/teams',  MX_INCLUDE_PATH )  # include invitees (mx teams)
  SportDb.read_setup( 'setups/teams',  BR_INCLUDE_PATH )

  ### fix!! -add setups/events  to setups; add all teams to setups/teams !!!!
  # [debug] parsing game (fixture) line: >Sáb 5 Ene 19:30  Morelia      3-3  Cruz Azul<
  # [debug]      match for team  >cruzazul< >Cruz Azul<
  # [debug]      match for team  >morelia< >Morelia<
  # [debug]    team1: >morelia<
  # [debug]    team2: >cruzazul<
  # [debug]    score: >19-30<
  #[debug]   line: >Sáb 5 Ene [SCORE]  [TEAM1]       3-3  [TEAM2] <

  SportDb.read_setup( 'setups/all',  AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  IT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH )

  ## fix!! --
  ## SportDb.read_setup( 'setups/all', MX_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', NORTH_AMERICA_CHAMPIONS_LEAGUE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', BR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', COPA_LIBERTADORES_INCLUDE_PATH )

  SportDb.read_setup( 'setups/all', WORLD_INCLUDE_PATH )  # circular reference; requires other teams
end


# - test sport.db.admin setup
task :admin => [:importbuiltin, :grounds] do
  ########
  # national teams

  SportDb.read_setup( 'setups/all',    NATIONAL_TEAMS_INCLUDE_PATH )

  SportDb.read_setup( 'setups/2012',   EURO_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014',   WORLD_CUP_INCLUDE_PATH )

  ################
  # clubs

  SportDb.read_setup( 'setups/teams',  WORLD_INCLUDE_PATH )

  SportDb.read_setup( 'setups/2013_14',  AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  IT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH )

  SportDb.read_setup( 'setups/2013_14', MX_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14', NORTH_AMERICA_CHAMPIONS_LEAGUE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013',    BR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013',    COPA_LIBERTADORES_INCLUDE_PATH )

  SportDb.read_setup( 'setups/2013',   WORLD_INCLUDE_PATH )  # circular reference; requires other teams
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

task :importsport => DATA_KEY.to_sym do
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


desc 'build book (draft version) - The Free Football World Almanac - from football.db'
task :book => :env do

  PAGES_DIR = "#{BUILD_DIR}/pages"  # use PAGES_OUTPUT_DIR or PAGES_ROOT ??

  require './scripts/book'


  build_book()                # multi-page version
  build_book( inline: true )  # all-in-one-page version a.k.a. inline version

  puts 'Done.'
end


desc 'build book (release version) - The Free Football World Almanac - from football.db'
task :publish => :env do

  PAGES_DIR = "../book/_pages"  # use PAGES_OUTPUT_DIR or PAGES_ROOT ??

  require './scripts/book'

  build_book()                # multi-page version
  build_book( inline: true )  # all-in-one-page version a.k.a. inline version

  puts 'Done.'
end



def check_repo_paths( ary )
  puts "checking repo paths..."

  ary.each do |entry|
    name = entry[0]
    path = entry[1]

    if Dir.exists?( path )    ## note: same as File.directory?()
      print '  OK               '
    else
      print '  -- NOT FOUND --  '
    end
    print " %-30s <%s>\n" % [name,path]
  end
end


desc 'check repo paths'
task :check => :env do
  check_repo_paths( ALL_REPO_PATHS )
end


desc 'print logs (stored in db)'
task :logs => :env do
  
  puts "db logs (#{LogDb::Models::Log.count})"
  LogDb::Models::Log.order(:id).each do |log|
     puts "  [#{log.level} ] #{log.ts}  - #{log.msg}"
  end

end


desc 'print versions of gems'
task :about => :env do
  puts ''
  puts 'gem versions'
  puts '============'
  puts "textutils      #{TextUtils::VERSION}     (#{TextUtils.root})"
  puts "worlddb        #{WorldDb::VERSION}     (#{WorldDb.root})"
  puts "sportdb        #{SportDb::VERSION}     (#{SportDb.root})"

  ## todo - add LogUtils  LogDb ??  - check for .root too
  ## add props and tagutils and activerecord_utils too

  ## fix: add PRE too ?? how??
  puts "activerecord  #{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}.#{ActiveRecord::VERSION::TINY}"
end


desc 'print stats for football.db tables/records'
task :stats => :env do
  puts ''
  puts 'world.db'
  puts '============'
  WorldDb.tables

  puts ''
  puts 'football.db'
  puts '==========='
  SportDb.tables
end



