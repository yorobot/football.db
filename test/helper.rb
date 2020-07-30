require_relative '../boot'


def setup_db( dbname='test' )
  dbfile = "./tmp/#{dbname}.db"
  File.delete( dbfile )  if File.exist?( dbfile )

  SportDb.connect( adapter:  'sqlite3',
                   database: dbfile )
  SportDb.create_all       ## build database schema (tables, indexes, etc.)


  ## turn on logging to console
  ## ActiveRecord::Base.logger = Logger.new( STDOUT )
end

