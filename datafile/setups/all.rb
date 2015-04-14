
task :all => [:importbuiltin, :grounds] do

  ########
  # national teams

  football 'national-teams'

  football 'euro-cup'
  football 'africa-cup'
  football 'north-america-gold-cup'
  football 'copa-america'
  football 'confed-cup'
  football 'world-cup'

  ################
  # clubs

  football 'clubs'
  football 'at-austria',     setup: 'teams'
  football 'de-deutschland', setup: 'teams'
  football 'eng-england',    setup: 'teams'
  football 'es-espana',      setup: 'teams'
  football 'it-italy',       setup: 'teams'

  football 'mx-mexico',      setup: 'teams'  # include invitees (mx teams)
  football 'br-brazil',      setup: 'teams'

  ### fix!! -add setups/events  to setups; add all teams to setups/teams !!!!
  # [debug] parsing game (fixture) line: >Sáb 5 Ene 19:30  Morelia      3-3  Cruz Azul<
  # [debug]      match for team  >cruzazul< >Cruz Azul<
  # [debug]      match for team  >morelia< >Morelia<
  # [debug]    team1: >morelia<
  # [debug]    team2: >cruzazul<
  # [debug]    score: >19-30<
  #[debug]   line: >Sáb 5 Ene [SCORE]  [TEAM1]       3-3  [TEAM2] <

  football 'at-austria'
  football 'de-deutschland'
  football 'eng-england'
  football 'es-espana'
  football 'it-italy'
  football 'europe-champions-league'

  ## fix!! --
  ## SportDb.read_setup( 'setups/all', MX_INCLUDE_PATH )
  football 'north-america-champions-league'
  football 'br-brazil'
  football 'copa-libertadores'

  football 'cup-world-cup'
end

