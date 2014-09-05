################################
# football clubs n leagues

task :es => :importbuiltin do
  SportDb.read_setup( 'setups/all',   ES_INCLUDE_PATH )
end

task :es_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014-15',  ES_INCLUDE_PATH )
end

