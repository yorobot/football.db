################################
# football clubs n leagues

task :fr => :importbuiltin do
  SportDb.read_setup( 'setups/all',  FR_INCLUDE_PATH )
end

task :fr_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014-15',  FR_INCLUDE_PATH )
end
