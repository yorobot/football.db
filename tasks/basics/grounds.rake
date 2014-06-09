######################
# grounds / stadiums

task :grounds  => :importbuiltin do
  SportDb.read_setup( 'setups/all',   STADIUMS_INCLUDE_PATH )
end

