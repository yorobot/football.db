
task :de => :importbuiltin do
  SportDb.read_setup( 'setups/all', DE_INCLUDE_PATH )
end


## create a summary (README.md) page for all clubs
task :de_index do   ### rename to de_index or de_clubs_index  or something ???
  clubs_dir = "#{DE_INCLUDE_PATH}/clubs"
  fixtures = find_files( clubs_dir, pattern: '**/*.txt' )
  pp fixtures

  buf = build_teams_report( fixtures, clubs_dir )

  puts buf

  File.open( "#{clubs_dir}/README.md", 'w' ) do |out|
    out.puts buf
  end
end



##
## use
##    rake build DATA=de

task :de_events => :configsport do
  seasons = (1964..2016).to_a
  add_seasons( seasons )

  fixtures = find_files( DE_INCLUDE_PATH, pattern: 'clubs/*.txt' )
  read_teams_for_country( 'de', DE_INCLUDE_PATH, fixtures )

  fixtures = find_files( DE_INCLUDE_PATH, pattern: '**/*.conf.txt' )
  read_table_events( DE_INCLUDE_PATH, fixtures )


  fixtures = find_files( DE_INCLUDE_PATH, pattern: '**/1-bundesliga.yml' )
  read_events( DE_INCLUDE_PATH, fixtures )

  fixtures = find_files( DE_INCLUDE_PATH, pattern: '**/2-bundesliga2.yml' )
  read_events( DE_INCLUDE_PATH, fixtures )

  fixtures = find_files( DE_INCLUDE_PATH, pattern: '**/3-liga3.yml' )
  read_events( DE_INCLUDE_PATH, fixtures )

  fixtures = find_files( DE_INCLUDE_PATH, pattern: '**/cup.yml' )
  read_events( DE_INCLUDE_PATH, fixtures )
end

task :de_stats => :configsport do
  dump_league( 'de' )
  dump_league( 'de.2' )
  dump_league( 'de.3' )
  dump_league( 'de.cup' )
end

task :de_clubs => :configsport do
  dump_teams( ['de', 'de.2', 'de.3', 'de.cup' ] )
end


task :recalc_de => :configsport do
  out_root = debug? ? './build/de-deutschland' : DE_INCLUDE_PATH

  [['de.2012/13'],
   ['de.2013/14', 'de.2.2013/14'],
   ['de.2014/15', 'de.2.2014/15'],
   ['de.2015/16', 'de.2.2015/16', 'de.3.2015/16'],
   ['de.2016/17', 'de.2.2016/17', 'de.3.2016/17']].each do |event_key|
     recalc_standings( event_key, out_root: out_root )
     ## recalc_stats( out_root: out_root )
  end
end
