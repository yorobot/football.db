# autofill / update scores in France


require_relative 'boot'



SportDb.connect( adapter:  'sqlite3',
                 database: './build/fr_csv.db' )
SportDb.tables



DATAFILES = [
  "#{OPENFOOTBALL_DIR}/france/2014-15/1-ligue1-ii.txt",
  "#{OPENFOOTBALL_DIR}/france/2014-15/2-ligue2-ii.txt",
]

DATAFILES.each do |path|
  txt = File.open( path, 'r:utf-8') { |f| f.read }

  filler = SportDb::AutoFiller.new( txt )
  txt_up, changelog = filler.autofill

  if changelog.size > 0    ## any changes? write-back
    puts txt_up
    pp changelog

    File.open( path, 'w:utf-8' ) { |f| f.write( txt_up ) }
  else
    puts "no changes"
  end
end
