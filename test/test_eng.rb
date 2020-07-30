##########
#  to run use
#    ruby test/test_eng.rb


start_time = Time.now   ## todo: use Timer? t = Timer.start / stop / diff etc. - why? why not?


require_relative './helper'

## more helpers
def read_eng( datafile )
  path = "#{OPENFOOTBALL_DIR}/england/#{datafile}"
  SportDb.read( path )
end


buf = String.new('')

## let's get started
setup_db( 'eng' )

### use a Timer helper object - why? why not?
end_time = Time.now
diff_time = end_time - start_time
buf << "  boot/setup_db: done in #{diff_time} sec(s)\n"



read_eng( 'archive/1880s/1888-89/1-footballleague.txt' )

read_eng( 'archive/1890s/1892-93/1-division1.txt' )
read_eng( 'archive/1890s/1892-93/2-division2.txt' )


SportDb.tables


puts buf

end_time = Time.now
diff_time = end_time - start_time
puts "test_eng: done in #{diff_time} sec(s)"





__END__
## read( 'england', season: '2019/20' )
## read( 'england' )

datafiles = Datafile.find_conf( "#{SOURCE_DIR}/england" )
puts "#{datafiles.size} conf datafiles:"
pp datafiles

## lint first (dry run - no database reads/updates/etc.)
SportDb.read( "#{SOURCE_DIR}/england", sync: false )
## SportDb.read( "#{SOURCE_DIR}/deutschland", sync: false )


## SportDb.read( "#{SOURCE_DIR}/england" )


SportDb.read( "#{SOURCE_DIR}/england/2015-16/.conf.txt" )
SportDb.read( "#{SOURCE_DIR}/england/2015-16/1-premierleague-i.txt" )
SportDb.read( "#{SOURCE_DIR}/england/2015-16/1-premierleague-ii.txt" )

## let's try another season
SportDb.read( "#{SOURCE_DIR}/england/2019-20/.conf.txt" )
SportDb.read( "#{SOURCE_DIR}/england/2019-20/1-premierleague.txt" )
