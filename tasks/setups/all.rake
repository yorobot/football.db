
task :all => [:importbuiltin, :grounds] do
  ########
  # national teams

  SportDb.read_setup( 'setups/all', NATIONAL_TEAMS_INCLUDE_PATH )

  SportDb.read_setup( 'setups/all', EURO_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', AFRICA_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', NORTH_AMERICA_GOLD_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', COPA_AMERICA_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', WORLD_CUP_INCLUDE_PATH )

  ################
  # clubs

  SportDb.read_setup( 'setups/teams',  WORLD_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',  AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',  DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',  EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',  ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/teams',  IT_INCLUDE_PATH )

  SportDb.read_setup( 'setups/teams',  MX_INCLUDE_PATH )  # include invitees (mx teams)
  SportDb.read_setup( 'setups/teams',  BR_INCLUDE_PATH )

  ### fix!! -add setups/events  to setups; add all teams to setups/teams !!!!
  # [debug] parsing game (fixture) line: >Sáb 5 Ene 19:30  Morelia      3-3  Cruz Azul<
  # [debug]      match for team  >cruzazul< >Cruz Azul<
  # [debug]      match for team  >morelia< >Morelia<
  # [debug]    team1: >morelia<
  # [debug]    team2: >cruzazul<
  # [debug]    score: >19-30<
  #[debug]   line: >Sáb 5 Ene [SCORE]  [TEAM1]       3-3  [TEAM2] <

  SportDb.read_setup( 'setups/all',  AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  IT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH )

  ## fix!! --
  ## SportDb.read_setup( 'setups/all', MX_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', NORTH_AMERICA_CHAMPIONS_LEAGUE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', BR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', COPA_LIBERTADORES_INCLUDE_PATH )

  SportDb.read_setup( 'setups/all', WORLD_INCLUDE_PATH )  # circular reference; requires other teams
end
