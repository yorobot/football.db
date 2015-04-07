
football 'openfootball/clubs', setup: 'teams'   ## CLUBS_INCLUDE_PATH


####################################
## was:

=begin
task :world => :importbuiltin do
  SportDb.read_setup( 'setups/teams',   CLUBS_INCLUDE_PATH )
end
=end
