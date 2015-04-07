
football 'openfootball/eng-england',    setup: 'teams'  ## ENG_INCLUDE_PATH
football 'openfootball/de-deutschland', setup: 'teams'  ## DE_INCLUDE_PATH
football 'openfootball/mx-mexico',      setup: 'teams'  ## MX_INCLUDE_PATH
football 'openfootball/br-brazil',      setup: 'teams'  ## BR_INCLUDE_PATH
football 'openfootball/clubs'                           ## CLUBS_INCLUDE_PATH


##########
# was:

=begin
task :clubs => :importbuiltin do
  ## todo/fix: add es,it,at too!!!
  SportDb.read_setup( 'setups/teams', EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', MX_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams', BR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',   CLUBS_INCLUDE_PATH )
end
=end
