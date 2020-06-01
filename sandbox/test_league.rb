require_relative 'boot'


puts "== Österr. Bundesliga:"
pp LEAGUES.match( 'Österr. Bundesliga' )

puts
puts "== Österr. Bundesliga - Relegation:"
pp LEAGUES.match( 'Österr. Bundesliga - Relegation' )
pp LEAGUES.match( 'AT REL' )
pp LEAGUES.match( 'Relegation' )
