################################
# football clubs n leagues

task :de => :importbuiltin do
  SportDb.read_setup( 'setups/all',  DE_INCLUDE_PATH )
end

task :de_2014_15 => :importbuiltin do
  SportDb.read_setup( 'setups/2014_15',  DE_INCLUDE_PATH )
end

