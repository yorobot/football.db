
task :at => :importbuiltin do
  SportDb.read_setup( 'setups/all', AT_INCLUDE_PATH )
end

## create a summary (README.md) page for all clubs
task :at_index do    ### rename to at_index or at_clubs_index  or something ???
  clubs_dir = "#{AT_INCLUDE_PATH}/clubs"

  fixtures = find_files( clubs_dir, pattern: '**/*.txt' )
  pp fixtures

  buf = build_teams_report( fixtures, clubs_dir )

  puts buf

  File.open( "#{clubs_dir}/README.md", 'w' ) do |out|
    out.puts buf
  end
end


task :at_events => :configsport do
  seasons = (1964..2016).to_a
  add_seasons( seasons )

  fixtures = find_files( AT_INCLUDE_PATH, pattern: 'clubs/*.txt' )
  read_teams_for_country( 'at', AT_INCLUDE_PATH, fixtures )

  fixtures = find_files( AT_INCLUDE_PATH, pattern: '**/1-bundesliga.yml' )
  read_events( AT_INCLUDE_PATH, fixtures )

  fixtures = find_files( AT_INCLUDE_PATH, pattern: '**/2-liga1.yml' )
  read_events( AT_INCLUDE_PATH, fixtures )

##  fixtures = find_files( AT_INCLUDE_PATH, pattern: '**/6-noe-nordwest-waldviertel.yml' )
##  read_events( AT_INCLUDE_PATH, fixtures )

  fixtures = find_files( AT_INCLUDE_PATH, pattern: '**/cup.yml' )
  read_events( AT_INCLUDE_PATH, fixtures )
end


task :at_stats => :configsport do
  dump_league( 'at' )
  dump_league( 'at.2' )
  dump_league( 'at.cup' )
end

task :at_clubs => :configsport do
  dump_teams( ['at', 'at.2', 'at.cup' ] )
end



task :recalc_at => :configsport do
  out_root = debug? ? './build/at-austria' : AT_INCLUDE_PATH

  [['at.2012/13'],
   ['at.2013/14'],
   ['at.2014/15', 'at.2.2014/15'],
   ['at.2015/16', 'at.2.2015/16'],
   ['at.2016/17', 'at.2.2016/17']].each do |event_key|
     recalc_standings( event_key, out_root: out_root  )
     ## recalc_stats( out_root: out_root )
  end
end
