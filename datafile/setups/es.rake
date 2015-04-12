################################
# football clubs n leagues

task :es => :importbuiltin do
  SportDb.read_setup( 'setups/all',   ES_INCLUDE_PATH )
end

task :es_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014-15',  ES_INCLUDE_PATH )
end


###
## fix: use ES_INCLUDE_PATH !!!!  - not ../es-espana

task :es_recalc => :es do
  ['es.2012/13',
   'es.2013/14',
   'es.2014/15'].each do |event_key|
     recalc_standings( event_key, out_root: '../es-espana' )
  end
end

task :es_2014_15_recalc => :es_2014_15 do
  recalc_standings( 'es.2014/15', out_root: '../es-espana' )
end
