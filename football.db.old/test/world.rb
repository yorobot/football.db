# encoding: utf-8


## world cup (world) from wikipedia


require_relative '../importers/wikipedia'



def process_world( year )
  ## search and replace mappings
  mappings = {
    teams:    {},
    stadiums: {},
  }


  page_a = Page.new( "./test/wikipedia/#{year}-world-a.txt", mappings: mappings )
  matches_a = page_a.football( 'Matches' )

  page_b = Page.new( "./test/wikipedia/#{year}-world-b.txt", mappings: mappings )
  matches_b = page_b.football( 'Matches' )

## pp matches_a
## pp matches_b


  puts "saving ./o/#{year}-world.txt..."
  File.open( "./o/#{year}-world.txt", "w:utf-8" ) do |out|
    out.puts "Group A:"
    out.puts format_matches( matches_a )
    out.puts
    out.puts "Group B:"
    out.puts format_matches( matches_b )
  end
end



## note: for now assume same structure for all seasons
years= [ '2018' ]

years.each do |year|
  process_world( year )
end
