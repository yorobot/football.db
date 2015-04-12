#####################
# national teams

task :copaamerica => :importbuiltin do
  SportDb.read_setup( 'setups/all',   NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',   COPA_AMERICA_INCLUDE_PATH )
end