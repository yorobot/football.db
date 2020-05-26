
task :en => :importbuiltin do
  SportDb.read_setup( 'setups/all', ENG_INCLUDE_PATH )
end


## for testing (new) 2017/18 season
##  use:
##   rake clean create importworld en18
task :en18 => :importbuiltin do
  SportDb.read_setup( 'setups/2017-18', ENG_INCLUDE_PATH )

  out_root = debug? ? './build/eng-england' : ENG_INCLUDE_PATH

  ['en.2017/18'].each do |event_key|
     recalc_standings( event_key, out_root: out_root  )
     ## recalc_stats( out_root: out_root )
  end
end



## create a summary (README.md) page for all clubs
task :en_index do       ### rename to en_index or en_clubs_index  or something ???
  clubs_dir = "#{ENG_INCLUDE_PATH}/clubs"
  fixtures = find_files( clubs_dir, pattern: '**/*.txt' )
  pp fixtures

  buf = build_teams_report( fixtures, clubs_dir )

  puts buf

  File.open( "#{clubs_dir}/README.md", 'w' ) do |out|
    out.puts buf
  end
end



task :en_events => :configsport do
  seasons = (1964..2016).to_a
  add_seasons( seasons )

  ##  todo: check if it works for clubs/wales.txt
  ##      wal overwrites default eng (country)?
  fixtures = find_files( ENG_INCLUDE_PATH, pattern: 'clubs/*.txt' )
  read_teams_for_country( 'eng', ENG_INCLUDE_PATH, fixtures )

  fixtures = find_files( ENG_INCLUDE_PATH, pattern: '**/*.conf.txt' )
  read_table_events( ENG_INCLUDE_PATH, fixtures )


  fixtures = find_files( ENG_INCLUDE_PATH, pattern: '**/1-premierleague.yml' )
  read_events( ENG_INCLUDE_PATH, fixtures )

  fixtures = find_files( ENG_INCLUDE_PATH, pattern: '**/2-championship.yml' )
  read_events( ENG_INCLUDE_PATH, fixtures )

  fixtures = find_files( ENG_INCLUDE_PATH, pattern: '**/3-league1.yml' )
  read_events( ENG_INCLUDE_PATH, fixtures )

  fixtures = find_files( ENG_INCLUDE_PATH, pattern: '**/4-league2.yml' )
  read_events( ENG_INCLUDE_PATH, fixtures )
end

task :en_stats => :configsport do
  dump_league( 'en' )
  dump_league( 'en.2' )
  dump_league( 'en.3' )
  dump_league( 'en.4' )
end

task :en_clubs => :configsport do
  dump_teams( ['en','en.2','en.3','en.4'] )
end




task :recalc_en => :configsport do
  out_root = debug? ? './build/eng-england' : ENG_INCLUDE_PATH

  ['en.2012/13',
   'en.2013/14',
   'en.2014/15',
   'en.2015/16',
   'en.2016/17',
   'en.2017/18',
  ].each do |event_key|
     recalc_standings( event_key, out_root: out_root )
     ## recalc_stats( out_root: out_root )
  end
end
