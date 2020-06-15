require_relative '../boot'


#########################
#  build leagues.db (from scratch) using datasets in footballcsv/cache.leagues


###############
#  setup database (from scratch)
DB_PATH = './build/leagues.db'
File.delete( DB_PATH )  if File.exist?( DB_PATH )

SportDb.connect( adapter:  'sqlite3',
                 database: DB_PATH )
SportDb.create_all


DATAFILES_DIR = "../../footballcsv/cache.leagues"

pack = SportDb::Package.new( DATAFILES_DIR )
pack.read_csv


SportDb.tables   ## print some stats

