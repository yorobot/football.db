

## create a summary (README.md) page for all clubs
task :nat_index do
  
  fixtures = find_files( NATIONAL_TEAMS_INCLUDE_PATH, pattern: '**/{teams,teams_*}.txt' )
  pp fixtures  

  buf = build_teams_report( fixtures, NATIONAL_TEAMS_INCLUDE_PATH, title: "National Teams" )

  puts buf
  
  File.open( "#{NATIONAL_TEAMS_INCLUDE_PATH}/SUMMARY.md", 'w' ) do |out|
    out.puts buf
  end

  regions = ['africa',
             'asia',
             'caribbean',
             'central-america',
             'europe',
             'middle-east',
             'north-america',
             'pacific',
             'south-america']
  
  regions.each do |region|
    region_dir = "#{NATIONAL_TEAMS_INCLUDE_PATH}/#{region}"
    fixtures = find_files( region_dir, pattern: '**/{teams,teams_*}.txt' )
    pp fixtures  

    buf = build_teams_report( fixtures, region_dir, title: "National Teams" )

    puts buf
  
    File.open( "#{region_dir}/README.md", 'w' ) do |out|
      out.puts buf
    end
  end
end
