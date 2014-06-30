
## fix: use official short codes/shortcuts e.g. america_cl?
task :northamericachampionsleague => :importbuiltin do
  SportDb.read_setup( 'setups/teams', MX_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', CLUBS_INCLUDE_PATH )   # use teams_north_america, central_america, caribbean ??
  SportDb.read_setup( 'setups/all',   NORTH_AMERICA_CHAMPIONS_LEAGUE_INCLUDE_PATH )
end

