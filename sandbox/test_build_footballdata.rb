require_relative '../boot'


#########################
#  build footballdata.db (from scratch) using datasets in footballcsv/cache.footballdata


###############
#  setup database (from scratch)
DB_PATH = './build/footballdata.db'
File.delete( DB_PATH )  if File.exist?( DB_PATH )

SportDb.connect( adapter:  'sqlite3',
                 database: DB_PATH )
SportDb.create_all


DATAFILES_DIR = "../../footballcsv/cache.footballdata"

pack = SportDb::Package.new( DATAFILES_DIR )
pack.read_csv


SportDb.tables   ## print some stats


#########################
#      38 leagues  /  36 seasons
#     687 events (league+season recs)  /  0 rounds  /  0 groups  /  0 stages
#    1142 teams
#  227309 matches
#

