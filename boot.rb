$LOAD_PATH.unshift( File.expand_path( '/Sites/rubycoco/monos/lib' ))
require 'sportdb/setup'
SportDb::Boot.setup   ## setup load path




# 3rd party libs/gems
require 'sportdb/readers'
require 'sportdb/importers'


SPORTDB_DIR      = "#{SportDb::Boot.root}/sportdb"     # path to libs
OPENFOOTBALL_DIR = "#{SportDb::Boot.root}/openfootball"

## use (switch to) "external" datasets
SportDb::Import.config.leagues_dir = "#{OPENFOOTBALL_DIR}/leagues"
SportDb::Import.config.clubs_dir   = "#{OPENFOOTBALL_DIR}/clubs"

## try from local datasets in zip archive
# SportDb::Import.config.leagues_dir = './tmp/leagues-master.zip'
# SportDb::Import.config.clubs_dir   = './tmp/clubs-master.zip'


COUNTRIES = SportDb::Import.catalog.countries
LEAGUES   = SportDb::Import.catalog.leagues
## add CLUBS - why? why not?
TEAMS     = SportDb::Import.catalog.teams



$LOAD_PATH.unshift( File.expand_path( "#{SportDb::Boot.root}/yorobot/sport.db.more/sportdb-auto/lib" ))

## note: MUST require linters AFTER changing leagues_dir/clubs_dir etc.
require 'sportdb/linters'
require 'sportdb/auto'      # incl. auto filler for score updates
