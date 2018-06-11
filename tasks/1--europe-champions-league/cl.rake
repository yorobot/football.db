
task :cl_base => :importbuiltin do
  SportDb.read_setup( 'setups/all', CLUBS_INCLUDE_PATH )

  SportDb.read_setup( 'setups/clubs', AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs', DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs', ENG_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs', ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs', IT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs', FR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/clubs', CH_INCLUDE_PATH )

  ## note:for now use clubs in clubs repos (not country repo)
  ### SportDb.read_setup( 'setups/clubs', RU_INCLUDE_PATH )
end

task :cl18 => :cl_base do
  SportDb.read_setup( 'setups/2017-18',  EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH )
end


task :json_cl => :configsport  do       ## for in-memory depends on all for now - ok??
  out_root = debug? ? './build' : JSON_REPO_PATH

  gen_json_clubs_intl( 'cl', out_root: out_root )
end
