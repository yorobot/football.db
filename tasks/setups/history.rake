#####################
# national teams

task :history => :importbuiltin do
  SportDb.read_setup( 'setups/all',     NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/history', NATIONAL_TEAMS_INCLUDE_PATH )

  ## note: will only include past world cups (not upcoming/future world cups e.g brazil 2014)
  SportDb.read_setup( 'setups/history', WORLD_CUP_INCLUDE_PATH )

  ## calc alltime standings
  st = SportDb::Model::AlltimeStanding.where( key: 'world' ).first_or_create! do |rec|
    puts 'alltime standings record does NOT exist - create it'
    rec.title = 'All Time World Cup'
  end
  st.recalc_for_league!( SportDb::Model::League.find_by_key!( 'world'),
                           merge: { 'ger' => 'frg',
                                    'rus' => 'urs',
                                    'cze' => 'tch',
                                    'srb' => 'yug',
                                    'idn' => 'dei',
                                    'cod' => 'zai' },
                           pts_exclude_scorep: true )

  dump_alltime_standings()
end
