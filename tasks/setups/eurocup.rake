#####################
# national teams

task :eurocup  => :importbuiltin do
  SportDb.read_setup( 'setups/all', NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', EURO_CUP_INCLUDE_PATH )
end

