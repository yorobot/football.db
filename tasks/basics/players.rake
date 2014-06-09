#######################
# players

task :players  => :importbuiltin do
  SportDb.read_setup( 'setups/all',   PLAYERS_INCLUDE_PATH )
end

