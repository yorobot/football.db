


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

