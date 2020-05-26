################################
# football clubs n leagues

task :at => :importbuiltin do
  SportDb.read_setup( 'setups/all',  AT_INCLUDE_PATH )
end

task :at_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014-15',  AT_INCLUDE_PATH )
end



task :at_recalc => :at do
  [['at.2012/13'],
   ['at.2013/14'],
   ['at.2014/15', 'at.2.2014/15']].each do |event_key|
     recalc_standings( event_key, out_root: AT_INCLUDE_PATH )
  end
end

task :at_2014_15_recalc => :at_2014_15 do
  recalc_standings( ['at.2014/15', 'at.2.2014/15'], out_root: AT_INCLUDE_PATH )
end


task :test_at_recalc => :env  do

  recalc_standings( ['at.2014/15', 'at.2.2014/15'], out_root: AT_INCLUDE_PATH )
  ## debug verison - write to ./build/at-austria 
  ## recalc_standings( ['at.2014/15', 'at.2.2014/15'], out_root: './build/at-austria' )
end


