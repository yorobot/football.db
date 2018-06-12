# encoding: utf-8


## champions league (cl) from wikipedia


require_relative '../importers/wikipedia'


## search and replace mappings
mappings = {
  teams:    { 'Munich'  => 'München' },
  stadiums: { 'Munich'  => 'München' }
}



page = Page.new( "./test/wikipedia/2017-18-cl-group.txt", mappings: mappings )

matches_a = page.football( "Group A" )
matches_b = page.football( "Group B" )
matches_c = page.football( "Group C" )

## pp matches_a
## pp matches_b
pp matches_c


page2   = Page.new( "./test/wikipedia/2017-18-cl-knockout.txt", mappings: mappings )
matches_q = page2.football( "Quarter-finals", sort: true )
pp matches_q


puts "Group A:"
puts format_matches( matches_a )
puts "Group B:"
puts format_matches( matches_b )
puts "Group C:"
puts format_matches( matches_c )

puts "Quarter-finals"
puts format_matches( matches_q )
