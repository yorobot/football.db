# encoding: utf-8

##############################
## todo: add goals etc. ???


def recalc_stats( opts={} )
  out_root = opts[:out_root] || './build'

  out_path = "#{out_root}/STATS.md"
  puts "out_path=>>#{out_path}<<"

  ## make sure parent folders exist
  FileUtils.mkdir_p( File.dirname(out_path) ) unless Dir.exists?( File.dirname( out_path ))

  File.open( out_path, 'w' ) do |out|
    out.puts "# Stats\n"
    out.puts "\n"
    out.puts "```\n"
    out.puts build_stats
    out.puts "```\n"
    out.puts "\n\n"
  end
end


def build_stats
  buf = ''
  buf << build_leagues
  ##  buf << build_teams    - note: build_teams (re)defined w/ args in team.rb!!! fix
  buf << build_events
  buf
end


def build_leagues
  buf = ''
  buf << "#{SportDb::Model::League.count} leagues\n"
  SportDb::Model::League.order(:id).each do |league|
    buf << "#{league.title} (#{league.key}) |  #{league.events.count} events\n"   ## todo: list years? why? why not??
  end
  buf
end

def build_teams
  buf = ''
  buf << "#{SportDb::Model::Team.count} teams\n"  ## todo: show national, clubs count etc.  ## group by country ???
  ## todo: loop over teams etc.
  buf
end


def build_events
  buf = ''
  buf << "#{SportDb::Model::Event.count} events:\n"
  SportDb::Model::Event.joins(:season).order('seasons.title desc').each do |event|
    buf << build_event( event )
  end
  buf
end


def build_event( event )
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
  buf << "\n"

  ## check if event has groups
  if event.groups.count > 0

=begin
      ## dump/print games by group
      event.groups.each do |group|
        dump_group( group )
        st = SportDb::Model::GroupStanding.where( group_id: group.id ).first
        dump_standing_entries( st.entries.order('pos') )
      end

      event.rounds.where( knockout: true ).each do |round|
        dump_round( round )
      end
=end
  else
    ## just dump all rounds (no groups)
    event.rounds.each do |round|
      buf << "#{round.pos} (#{round.games.count})  "
    end
  end

  buf << "\n\n"
  buf
end
