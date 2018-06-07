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
     puts "groups.count: #{event.groups.count}"
     puts "grounds.count: #{event.grounds.count}"


     grounds = []
     event.grounds.each do |ground|
        grounds << { key:      ground.key,
                     name:     ground.title,
                     capacity: ground.capacity,
                     city:     ground.city.name }
     end

     hash_grounds = {
      name:     event.title,
      stadiums: grounds
     }

     pp hash_grounds


     teams = []
     event.teams.each do |team|
       teams << { key:  team.key, name: team.title, code: team.code }
     end

     hash_teams = {
      name: event.title,
      teams: teams
     }

     pp hash_teams


     standings = []
     event.groups.each do |group|
       entries = []
       group_standing = SportDb::Model::GroupStanding.find_by!( group_id: group.id )
       group_standing.entries.each do |entry|
          entries << { team: { key: entry.team.key, name: entry.team.name, code: entry.team.code },
                       rank:          entry.pos,
                       played:        entry.played,
                       won:           entry.won,
                       drawn:         entry.drawn,
                       lost:          entry.lost,
                       goals_for:     entry.goals_for,
                       goals_against: entry.goals_against,
                       pts:           entry.pts
                     }
        end
        standings << { name: group.title, standings: entries }
     end

     hash_standings = {
      name:   event.title,
      groups: standings
     }

     pp hash_standings



     groups = []
     event.groups.each do |group|
       teams  = []
       group.teams.each do |team|
         teams << { key:  team.key,
                    name: team.title,
                    code: team.code
                  }
       end
       groups << { name: group.title, teams: teams }
     end

     hash_groups = {
      name: event.title,
      groups: groups
     }

     pp hash_groups




     rounds = []
     event.rounds.each do |round|
       matches = []
       round.games.each do |game|
         matches << { num:  game.pos,
                      date: game.play_at.strftime( '%Y-%m-%d'),
                      time: game.play_at.strftime( '%H:%M'),
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
                      score1:    game.score1,
                      score2:    game.score2,
                      score1i:   game.score1i,   # half time / first third (opt)
                      score2i:   game.score2i,   # half time - team 2
                      score1et:  game.score1et,  # extratime - team 1 (opt)
                      score2et:  game.score2et,  # extratime - team 2 (opt)
                      score1p:   game.score1p,   # penalty  - team 1 (opt)
                      score2p:   game.score2p,   # penalty  - team 2 (opt) elfmeter (opt)
                      knockout:  game.knockout,
                      group:     game.group  ? game.group.title : nil,
                      stadium:    game.ground ? ({ key: game.ground.key, name: game.ground.title, city: game.ground.city.name }) : nil }
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

     File.open( "#{out_dir}/#{league_basename}.stadiums.json", 'w' ) do |f|
       f.write JSON.pretty_generate( hash_grounds )
     end

     File.open( "#{out_dir}/#{league_basename}.teams.json", 'w' ) do |f|
       f.write JSON.pretty_generate( hash_teams )
     end

     File.open( "#{out_dir}/#{league_basename}.groups.json", 'w' ) do |f|
       f.write JSON.pretty_generate( hash_groups )
     end

     File.open( "#{out_dir}/#{league_basename}.standings.json", 'w' ) do |f|
       f.write JSON.pretty_generate( hash_standings )
     end

     File.open( "#{out_dir}/#{league_basename}.json", 'w' ) do |f|
       f.write JSON.pretty_generate( hash_matches )
     end
  end

end
