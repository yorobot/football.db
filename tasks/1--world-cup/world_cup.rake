

task :worldcup2018 => :importbuiltin do
  SportDb.read_setup( 'setups/all',  NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2018', WORLD_CUP_INCLUDE_PATH )
end


task :recalc_worldcup2018 => :configsport do
end
