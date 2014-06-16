

desc 'print alltime stats (for checksum mostly)'
task :alltime_stats => :env do
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

