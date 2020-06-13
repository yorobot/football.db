# autofill / update scores in
#   - deutschland
#   - austria
#   - espana
#   - ...



require_relative 'boot'



SportDb.connect( adapter:  'sqlite3',
                 database: './build/updates.db' )
SportDb.tables



DATAFILES = [
  "#{OPENFOOTBALL_DIR}/deutschland/2019-20/2-bundesliga2.txt",
  "#{OPENFOOTBALL_DIR}/deutschland/2019-20/3-liga3.txt",
  "#{OPENFOOTBALL_DIR}/austria/2019-20/1-bundesliga-ii.txt",
  "#{OPENFOOTBALL_DIR}/austria/2019-20/2-liga2.txt",
  "#{OPENFOOTBALL_DIR}/espana/2019-20/1-liga.txt",
  # "#{OPENFOOTBALL_DIR}/espana/2019-20/2-liga2.txt",  ## note: for now only works with at least on db record present for event (fix!!!)
]

DATAFILES.each do |path|
  txt = File.open( path, 'r:utf-8') { |f| f.read }

  filler = SportDb::AutoFiller.new( txt )
  txt_up, changelog = filler.autofill

  if changelog.size > 0    ## any changes? write-back
    # puts txt_up
    pp changelog

    File.open( path, 'w:utf-8' ) { |f| f.write( txt_up ) }
  else
    puts "no changes"
  end
end
