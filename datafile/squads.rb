

football 'openfootball/national-teams'                       ##  NATIONAL_TEAMS_INCLUDE_PATH
football 'openfootball/world-cup',     setup: '2014_squads'  ##  WORLD_CUP_INCLUDE_PATH


###############
##  was:  -- add depends on 'players' -- why? why not??

=begin
############################
# todo: squads - move to worldcup.rake ??

task :squads => :players do
  ## test/try squads for worldcup 2014
  ## add importbuiltin dep too (or reuse from players) ?? why? why not??

  SportDb.read_setup( 'setups/all',          NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014_squads',  WORLD_CUP_INCLUDE_PATH )
end
=end
