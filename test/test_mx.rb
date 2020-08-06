##########
#  to run use
#    ruby test/test_mx.rb


start_time = Time.now   ## todo: use Timer? t = Timer.start / stop / diff etc. - why? why not?


require_relative './helper'

## more helpers
def read_au( datafile )
  path = "#{OPENFOOTBALL_DIR}/mexico/#{datafile}"
  SportDb.read( path )
end


## let's get started
setup( 'mx' )


read_au( '2018-19/1-apertura.txt' )


SportDb.tables


end_time = Time.now
diff_time = end_time - start_time
puts "test_mx: done in #{diff_time} sec(s)"



