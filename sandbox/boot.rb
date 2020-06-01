
$RUBYLIBS_DEBUG = true


SPORTDB_DIR      = '../../sportdb'     # path to libs

## note: use the local version of sportdb gems
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-formats/lib" ))

# $LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/football.db/footballdb-leagues/lib" ))
# $LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/football.db/footballdb-clubs/lib" ))

$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-config/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-models/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-readers/lib" ))
$LOAD_PATH.unshift( File.expand_path( "#{SPORTDB_DIR}/sport.db/sportdb-sync/lib" ))

$LOAD_PATH.unshift( File.expand_path( "../football.csv/sportdb-linters/lib" ))


# 3rd party libs/gems
require 'sportdb/readers'



OPENFOOTBALL_DIR = "../../openfootball"

## use (switch to) "external" datasets
SportDb::Import.config.leagues_dir = "#{OPENFOOTBALL_DIR}/leagues"
SportDb::Import.config.clubs_dir   = "#{OPENFOOTBALL_DIR}/clubs"

LEAGUES = SportDb::Import.catalog.leagues


require 'sportdb/linters'

