################################
# football clubs n leagues

task :cl_2013_14  => :importbuiltin do
  SportDb.read_setup( 'setups/clubs',    CLUBS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    IT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    FR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    CH_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013-14',  EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH )
end

task :cl_2014_15  => :importbuiltin do
  SportDb.read_setup( 'setups/clubs',    CLUBS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    IT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    FR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs',    CH_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014-15',  EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH )
end



task :test_cl_recalc => :env  do

  recalc_standings( ['cl.2014/15' ], out_root: EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH )

  ## debug verison - write to ./build/at-austria 
  ## recalc_standings( ['cl.2014/15'], out_root: './build/europe-champions-league' )
end

