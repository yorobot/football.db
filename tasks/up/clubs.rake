
## create a summary (README.md) page for all clubs
task :clubs_index do
  
  fixtures = find_files( CLUBS_INCLUDE_PATH, pattern: '**/{clubs,clubs_*}.txt' )
  pp fixtures  

  buf = build_teams_report( fixtures, CLUBS_INCLUDE_PATH )

  puts buf
  
  File.open( "#{CLUBS_INCLUDE_PATH}/SUMMARY.md", 'w' ) do |out|
    out.puts buf
  end

  regions = ['africa',
             'asia',
             'caribbean',
             'central-america',
             'europe',
             'middle-east',
             'pacific',
             'south-america']
  
  regions.each do |region|
    region_dir = "#{CLUBS_INCLUDE_PATH}/#{region}"
    fixtures = find_files( region_dir, pattern: '**/{clubs,clubs_*}.txt' )
    pp fixtures  

    buf = build_teams_report( fixtures, region_dir )

    puts buf
  
    File.open( "#{region_dir}/README.md", 'w' ) do |out|
      out.puts buf
    end
  end

end
