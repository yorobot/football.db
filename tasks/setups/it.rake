################################
# football clubs n leagues

task :it => :importbuiltin do
  SportDb.read_setup( 'setups/all',  IT_INCLUDE_PATH )
end

task :it_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014-15',  IT_INCLUDE_PATH )
end



###
## fix: use IT_INCLUDE_PATH !!!!  - not ../it-italy


task :it_recalc => :it do
  ['it.2013/14',
   'it.2014/15'].each do |event_key|
     recalc_standings( event_key, out_root: '../it-italy' )
  end
end

task :it_2014_15_recalc => :it_2014_15 do
  recalc_standings( 'it.2014/15', out_root: '../it-italy' )
end
