#####################
# national teams

task :worldcup => :importbuiltin do
  SportDb.read_setup( 'setups/all',   NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',   WORLD_CUP_INCLUDE_PATH )
end

task :worldcup2014 => :importbuiltin do
  SportDb.read_setup( 'setups/all',          NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014_quali',   WORLD_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014',         WORLD_CUP_INCLUDE_PATH )
end

task :worldcup2014q => :importbuiltin do
  SportDb.read_setup( 'setups/all',          NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014_quali',   WORLD_CUP_INCLUDE_PATH )
end
