$RUBYLIBS_DEBUG = true


def debug?
  value = ENV['DEBUG']
  if value && ['true', 't', 'yes', 'y'].include?( value.downcase )
    true
  else
    false
  end
end



SPORTDB_DIR      = '../../sportdb'     # path to libs

## note: use the local version of sportdb gems
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-formats/lib" ))

# $LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/football.db/footballdb-leagues/lib" ))
# $LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/football.db/footballdb-clubs/lib" ))

$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-config/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-models/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-sync/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-readers/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-importers/lib" ))


# 3rd party libs/gems
require 'sportdb/readers'
require 'sportdb/importers'


OPENFOOTBALL_DIR = "../../openfootball"

## use (switch to) "external" datasets
SportDb::Import.config.leagues_dir = "#{OPENFOOTBALL_DIR}/leagues"
SportDb::Import.config.clubs_dir   = "#{OPENFOOTBALL_DIR}/clubs"

COUNTRIES = SportDb::Import.catalog.countries
LEAGUES   = SportDb::Import.catalog.leagues
## add CLUBS - why? why not?
TEAMS     = SportDb::Import.catalog.teams



$LOAD_PATH.unshift( File.expand_path( "../football.csv/sportdb-linters/lib" ))
$LOAD_PATH.unshift( File.expand_path( "../football.csv/sportdb-auto/lib" ))

## note: MUST require linters AFTER changing leagues_dir/clubs_dir etc.
require 'sportdb/linters'
require 'sportdb/auto'      # incl. auto filler for score updates
