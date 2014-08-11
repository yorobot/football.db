################################
# football clubs n leagues

task :en => :importbuiltin do
  SportDb.read_setup( 'setups/all',  EN_INCLUDE_PATH )
end


task :en_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014-15',  EN_INCLUDE_PATH )
end

