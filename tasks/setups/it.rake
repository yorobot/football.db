################################
# football clubs n leagues

task :it => :importbuiltin do
  SportDb.read_setup( 'setups/all',  IT_INCLUDE_PATH )
end

task :it_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014-15',  IT_INCLUDE_PATH )
end

