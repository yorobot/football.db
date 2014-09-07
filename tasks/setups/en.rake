################################
# football clubs n leagues

task :en => :importbuiltin do
  SportDb.read_setup( 'setups/all',  EN_INCLUDE_PATH )
end


task :en_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014-15',  EN_INCLUDE_PATH )
end


###
## fix: use EN_INCLUDE_PATH !!!!  - not ../en-england

task :en_recalc => :en do
  ['en.2012/13',
   'en.2013/14',
   'en.2014/15'].each do |event_key|
     recalc_standings( event_key, out_root: '../en-england' )
  end
end

task :en_2014_15_recalc => :en_2014_15 do
  recalc_standings( 'en.2014/15', out_root: '../en-england' )
end

