################################
# football clubs n leagues

task :es => :importbuiltin do
  SportDb.read_setup( 'setups/all',   ES_INCLUDE_PATH )
end

