
football 'openfootball/clubs',     setup: 'teams'  ## CLUBS_INCLUDE_PATH - ## use teams_europe ??
football 'openfootball/at-austria'                 ## AT_INCLUDE_PATH
football 'openfootball/de-deutschland'             ## DE_INCLUDE_PATH
football 'openfootball/eng-england'                ## EN_INCLUDE_PATH
football 'openfootball/es-espana'                  ## ES_INCLUDE_PATH
football 'openfootball/it-italy'                   ## IT_INCLUDE_PATH


####################
## was:

=begin
task :europe_clubs => :importbuiltin do
  SportDb.read_setup( 'setups/teams',  CLUBS_INCLUDE_PATH )   ## use teams_europe ??
  SportDb.read_setup( 'setups/all',    AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',    IT_INCLUDE_PATH )
end
=end