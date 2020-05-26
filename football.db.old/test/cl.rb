# encoding: utf-8


## champions league (cl) from wikipedia


require_relative '../importers/wikipedia'



def process_cl( season )
  ## search and replace mappings
  mappings = {
    teams:    { 'Munich'  => 'München' },
    stadiums: { 'Munich'  => 'München' }
  }

  page = Page.new( "./test/wikipedia/#{season}-cl-group.txt", mappings: mappings )

  matches_a = page.football( 'Group A' )
  matches_b = page.football( 'Group B' )
  matches_c = page.football( 'Group C' )
  matches_d = page.football( 'Group D' )
  matches_e = page.football( 'Group E' )
  matches_f = page.football( 'Group F' )
  matches_g = page.football( 'Group G' )
  matches_h = page.football( 'Group H' )

## pp matches_a
## pp matches_b
## pp matches_c

  ## todo/fix: assert matches must be six (6) for 3x2 for each group

  page2   = Page.new( "./test/wikipedia/#{season}-cl-knockout.txt", mappings: mappings )

  matches_16 = page2.football( 'Round of 16',    sort: true )
  matches_8  = page2.football( 'Quarter-finals', sort: true )
  matches_4  = page2.football( 'Semi-finals',    sort: true )

  ##  pp matches_16

  ## note: final gets include in knockout with a template form cl-final
  page3   = Page.new( "./test/wikipedia/#{season}-cl-final.txt", mappings: mappings )

  matches_2  = page3.football( 'Match' )   ## use subheading Details - why? why not?
  pp matches_2


  puts "saving ./o/#{season}-cl.txt..."
  File.open( "./o/#{season}-cl.txt", "w:utf-8" ) do |out|
    out.puts "Group A:"
    out.puts format_matches( matches_a )
    out.puts
    out.puts "Group B:"
    out.puts format_matches( matches_b )
    out.puts
    out.puts "Group C:"
    out.puts format_matches( matches_c )
    out.puts
    out.puts "Group D:"
    out.puts format_matches( matches_d )
    out.puts
    out.puts "Group E:"
    out.puts format_matches( matches_e )
    out.puts
    out.puts "Group F:"
    out.puts format_matches( matches_f )
    out.puts
    out.puts "Group G:"
    out.puts format_matches( matches_g )
    out.puts
    out.puts "Group H:"
    out.puts format_matches( matches_h )
  end


  puts "saving ./o/#{season}-cl-finals.txt..."
  File.open( "./o/#{season}-cl-finals.txt", "w:utf-8" ) do |out|
    out.puts "Round of 16"
    out.puts format_matches( matches_16 )
    out.puts
    out.puts "Quarter-finals"
    out.puts format_matches( matches_8 )
    out.puts
    out.puts "Semi-finals"
    out.puts format_matches( matches_4 )
    out.puts
    out.puts "Final"
    out.puts format_matches( matches_2 )
  end
end



## note: for now assume same structure for all seasons
seasons= [ '2017-18', '2016-17', '2015-16' ]

seasons.each do |season|
  process_cl( season )
end
