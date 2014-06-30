
task :copalibertadores => :importbuiltin do
  SportDb.read_setup( 'setups/teams', MX_INCLUDE_PATH )  # include invitees (mx teams)
  SportDb.read_setup( 'setups/teams', BR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', CLUBS_INCLUDE_PATH )  # use teams_south_america ??
  SportDb.read_setup( 'setups/all',   COPA_LIBERTADORES_INCLUDE_PATH )
end
