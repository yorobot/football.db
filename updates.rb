#########################
#  build updates.db (from scratch) using datasets in footballcsv/cache.updates

require_relative 'boot'



###############
#  setup database (from scratch)
DB_PATH = './build/updates.db'
File.delete( DB_PATH )  if File.exist?( DB_PATH )

SportDb.connect( adapter:  'sqlite3',
                 database: DB_PATH )
SportDb.create_all



UPDATES_DIR = "../../footballcsv/cache.updates"

pack = SportDb::Package.new( UPDATES_DIR )
pack.read_csv


SportDb.tables   ## print some stats
