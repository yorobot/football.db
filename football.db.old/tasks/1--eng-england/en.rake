


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

