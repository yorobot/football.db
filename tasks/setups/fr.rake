################################
# football clubs n leagues

task :fr => :importbuiltin do
  SportDb.read_setup( 'setups/all',  FR_INCLUDE_PATH )
end

