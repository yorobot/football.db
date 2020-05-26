################################
# football clubs n leagues

task :fr => :importbuiltin do
  SportDb.read_setup( 'setups/all',  FR_INCLUDE_PATH )
end

task :fr_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014-15',  FR_INCLUDE_PATH )
end


###
## fix: use FR_INCLUDE_PATH !!!!  - not ../fr-france


task :fr_recalc => :fr do
  ['fr.2014/15'].each do |event_key|
     recalc_standings( event_key, out_root: '../fr-france' )
  end
end

task :fr_2014_15_recalc => :fr_2014_15 do
  recalc_standings( 'fr.2014/15', out_root: '../fr-france' )
end
