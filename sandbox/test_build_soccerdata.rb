require_relative '../boot'


#########################
#  build soccerdata.db (from scratch) using datasets in footballcsv/cache.soccerdata


###############
#  setup database (from scratch)
DB_PATH = './build/soccerdata.db'
File.delete( DB_PATH )  if File.exist?( DB_PATH )

SportDb.connect( adapter:  'sqlite3',
                 database: DB_PATH )
SportDb.create_all


DATAFILES_DIR = "../../footballcsv/cache.soccerdata"

pack = SportDb::Package.new( DATAFILES_DIR )
pack.read_csv


SportDb.tables   ## print some stats

############################
#       6 leagues  /  118 seasons
#     411 events (league+season recs)  /  0 rounds  /  0 groups  /  0 stages
#     141 teams
#  194040 matches