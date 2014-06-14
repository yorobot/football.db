# encoding: utf-8


desc 'print all events w/ groups and matches'
task :dump => :env do

  # recalc_groups!

  event_key = ENV['EVENT']
  puts "event_key=#{event_key}"

  team_key = ENV['TEAM']
  puts "team_key=#{team_key}"

  if event_key.present?
    event = SportDb::Model::Event.find_by_key!( event_key )
    dump_event( event )
  elsif team_key.present?
    team  = SportDb::Model::Team.find_by_key!( team_key )
    dump_team( team )
  else   ## default dump all events
    dump_events
  end

end


task :recalc => :env do
  recalc_groups!
end



task :check_incomplete => :env do
  ## check for incomplete matches (e.g. incomplete scores)
  games = SportDb::Model::Game.order(:id)
  
  count = 0
  
  games.each do |game|
    if game.complete?
      print '.'
    else
      count += 1
      puts ''
      puts "*** incomplete match -  #{game.round.event.title} / #{game.round.title}"
      dump_game( game )
    end
  end

  puts ''
  puts "*** found #{count} incomplete match scores"
end



def recalc_groups!
  SportDb::Model::Event.joins(:season).order('seasons.title desc').each do |event|
    recalc_groups_for_event!( event )
  end
end

def recalc_groups_for_event!( event )
  event.groups.each do |group|
    # calc group standings and dump too
    st = SportDb::Model::GroupStanding.where( group_id: group.id ).first_or_create! do |rec|
      puts 'group standings record does NOT exist - create it'
      # rec.title = "#{group.title}"
    end
    st.recalc!
  end
end


def dump_team( team )

  puts "#####################"
  puts "## #{team.title} (#{team.code})"
  puts "         #{team.events.count} events, #{team.games.count} matches (#{team.home_games.count} home, #{team.away_games.count} away)"

  ## dump alltime standing entries if exists for team (should be just one)
  entries = SportDb::Model::AlltimeStandingEntry.where( team_id: team.id )
  if entries
    dump_standing_entries( entries )
  end

  matches_count = 0
  SportDb::Model::Event.joins(:season).order('seasons.title desc').each do |event|
    t = event.teams.where( key: team.key ).first
    if t  ###
      event_matches = event.games.where('team1_id = ? OR team2_id = ?', team.id, team.id)
      event_matches_count = event_matches.count
      matches_count += event_matches_count

      ## double check calc stats
      ## todo only add in debug mode
      check_calc = false
      if check_calc  # todo: add as option - how?
        recs = SportDb::StandingsHelper.calc_stats( event.games )
        team_rec = recs[ team.key ]
        puts "   calc_stats -  #{team_rec.played} matches"
      end

      puts "  -- YES --  #{event.title}  | +#{event_matches_count} matches  = #{matches_count}"

      if event_matches_count > 0
        event_matches.each do |game|
          buf = ''
          buf << "    #{game.round.title}"
          buf << " (K.O.) "                if game.round.knockout
          buf << " / #{game.group.title}"  if game.group
          puts buf
          dump_game( game )
        end
      end
    else
      puts "  --  Ø  --  #{event.title}"
    end
  end
end



def dump_events
  SportDb::Model::Event.joins(:season).order('seasons.title desc').each do |event|
    dump_event( event )
    puts ' '
  end
end

def dump_event( event )
    buf = ''
    buf << "#######################\n"
    buf << "## #{event.season.title} #{event.league.title}  "
    buf << "|  #{event.teams.count} Teams"
    buf << ", #{event.games.count} Matches"
    
    score1 = event.games.sum(:score1 )
    score2 = event.games.sum(:score2 )
    score1et = event.games.sum(:score1et )
    score2et = event.games.sum(:score2et )

    ## check/todo: add penalty (shootout) too? - skip for now

    buf << ", #{score1+score2+score1et+score2et} Goals (+#{score1et+score2et} a.e.t.)"
    buf << "\n"
    buf << "    #{event.groups.count} Groups"
    buf << ", #{event.rounds.count} Rounds (#{event.rounds.where(knockout:false).count} Matchdays, #{event.rounds.where(knockout:true).count} K.O.s)"

    puts buf

    ## check if event has groups
    if event.groups.count > 0

      ## dump/print games by group
      event.groups.each do |group|
        dump_group( group )
        st = SportDb::Model::GroupStanding.where( group_id: group.id ).first
        dump_standing_entries( st.entries.order('pos') )
      end

      event.rounds.where( knockout: true ).each do |round|
        dump_round( round )
      end

    else
      ## just dump all rounds (no groups)
      event.rounds.each do |round|
        dump_round( round )
      end
    end
end


def dump_group( group )
  buf = ''
  buf << " ### #{group.title}   | "
  buf << " #{group.teams.count} Teams - "
  group.teams.each do |team|
    buf << "#{team.title}  "
  end
  ## add status too
  buf << "  |  #{group.games.count} Matches"
  puts buf

  group.games.each do |game|
    dump_game( game )
  end
end

def dump_round( round )
  buf = ''
  buf << " ### (#{round.pos}) #{round.title} "
  buf << "(K.O.)"  if round.knockout
  buf << "   | #{round.games.count} Matches"
  puts buf

  round.games.each do |game|
    dump_game( game )
  end
end


def dump_game( game )
  buf = '    '
  buf << "%4s "  % "(#{game.pos})"

  buf << "%6s  " % "#{game.play_at.strftime("%b %d")}"
  # buf << "%12s " % "#{game.play_at.strftime("%b %d, %Y")}"
  
  buf << "%-42s " % "#{game.team1.title} (#{game.team1.code}) - #{game.team2.title} (#{game.team2.code})"

  ## fix/change - print  4-4nV first
  buf << "  #{game.score_str}"

  puts buf
end
