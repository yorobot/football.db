################################
# football clubs n leagues

task :at => :importbuiltin do
  SportDb.read_setup( 'setups/all',  AT_INCLUDE_PATH )
end

task :at_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014_15',  AT_INCLUDE_PATH )
end

