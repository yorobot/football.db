#####################
# national teams

task :goldcup  => :importbuiltin do
  SportDb.read_setup( 'setups/all', NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', NORTH_AMERICA_GOLD_CUP_INCLUDE_PATH )
end

