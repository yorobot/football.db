# encoding: utf-8


LEAGUE_TO_BASENAME = {
  'at'    => 'at.1',
  'de'    => 'de.1',
  'en'    => 'en.1',
  'es'    => 'es.1',
  'it'    => 'it.1',
  'world' => 'worldcup',
}



def gen_json( league_key, opts={} )

  out_root = opts[:out_root] || './build'

  league = SportDb::Model::League.find_by_key!( league_key )

  league.events.each do |event|
     puts "** event:"
     pp event.title
     pp event.season
     pp event.league
     puts "teams.count: #{event.teams.count}"
     puts "rounds.count: #{event.rounds.count}"


     clubs = []
     event.teams.each do |team|
       clubs << { key:  team.key, name: team.title, code: team.code }
     end

     hash_clubs = {
      name: event.title,
      clubs: clubs
     }

     pp hash_clubs


     rounds = []
     event.rounds.each do |round|
       matches = []
       round.games.each do |game|
         matches << { date: game.play_at.strftime( '%Y-%m-%d'),
                      team1: {
                        key:  game.team1.key,
                        name: game.team1.title,
                        code: game.team1.code
                      },
                      team2: {
                        key:  game.team2.key,
                        name: game.team2.title,
                        code: game.team2.code
                      },
                      score1: game.score1,
                      score2: game.score2 }
       end

       rounds << { name: round.title, matches: matches }
     end

     hash_matches =  {
       name: event.title,
       rounds: rounds
     }

     pp hash_matches


     ## build path e.g.
     ##  2014-15/at.1.clubs.json

     ##  -- check for remapping (e.g. add .1); if not found use league key as is
     league_basename = LEAGUE_TO_BASENAME[ event.league.key ] || event.league.key

     season_basename = event.season.title.sub('/', '-')  ## e.g. change 2014/15 to 2014-15


     out_dir   = "#{out_root}/#{season_basename}"
     ## make sure folders exist
     FileUtils.mkdir_p( out_dir ) unless Dir.exists?( out_dir )

     File.open( "#{out_dir}/#{league_basename}.clubs.json", 'w' ) do |f|
       f.write JSON.pretty_generate( hash_clubs )
     end

     File.open( "#{out_dir}/#{league_basename}.json", 'w' ) do |f|
       f.write JSON.pretty_generate( hash_matches )
     end
  end

end



####
# todo/fix: move to its own file????

def gen_json_worldcup( league_key, opts={} )

  out_root = opts[:out_root] || './build'

  league = SportDb::Model::League.find_by_key!( league_key )

  league.events.each do |event|
     puts "** event:"
     pp event.title
     pp event.season
     pp event.league
     puts "teams.count: #{event.teams.count}"
     puts "rounds.count: #{event.rounds.count}"


     clubs = []
     event.teams.each do |team|
       clubs << { key:  team.key, name: team.title, code: team.code }
     end

     hash_clubs = {
      name: event.title,
      clubs: clubs
     }

     pp hash_clubs


     rounds = []
     event.rounds.each do |round|
       matches = []
       round.games.each do |game|
         matches << { date: game.play_at.strftime( '%Y-%m-%d'),
                      team1: {
                        key:  game.team1.key,
                        name: game.team1.title,
                        code: game.team1.code
                      },
                      team2: {
                        key:  game.team2.key,
                        name: game.team2.title,
                        code: game.team2.code
                      },
                      score1: game.score1,
                      score2: game.score2 }
       end

       rounds << { name: round.title, matches: matches }
     end

     hash_matches =  {
       name: event.title,
       rounds: rounds
     }

     pp hash_matches


     ## build path e.g.
     ##  2014-15/at.1.clubs.json
     ##  2018/worldcup.teams.json

     ##  -- check for remapping (e.g. add .1); if not found use league key as is
     league_basename = LEAGUE_TO_BASENAME[ event.league.key ] || event.league.key

     season_basename = event.season.title.sub('/', '-')  ## e.g. change 2014/15 to 2014-15


     out_dir   = "#{out_root}/#{season_basename}"
     ## make sure folders exist
     FileUtils.mkdir_p( out_dir ) unless Dir.exists?( out_dir )

     File.open( "#{out_dir}/#{league_basename}.teams.json", 'w' ) do |f|
       f.write JSON.pretty_generate( hash_clubs )
     end

     File.open( "#{out_dir}/#{league_basename}.json", 'w' ) do |f|
       f.write JSON.pretty_generate( hash_matches )
     end
  end

end
