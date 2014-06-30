################################
# football clubs n leagues

task :cl201314  => :importbuiltin do
  SportDb.read_setup( 'setups/teams',    CLUBS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',    AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',    DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',    EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',    ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',    IT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH )
end

