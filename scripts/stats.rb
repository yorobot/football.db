##############################
## todo: add goals etc. ???


def build_logs
  buf = ''
  buf << "#{LogDb::Model::Log.count} logs:\n"    ## show count for warn, error, info etc.
  LogDb::Model::Log.order('created_at').each do |log|
    buf << "[#{log.level}] #{log.msg}\n"     unless log.msg.start_with?( 'Rakefile')  ## skip Hello Rakefile logs
  end
  buf
end



def build_stats
  buf = ''
  buf << build_summary
  buf << "\n\n"
  buf << build_leagues
  buf << "\n\n"
  buf << build_seasons
  buf << "\n\n"
  buf << build_events
  buf
end


def build_leagues
  buf = ''
  buf << "#{SportDb::Model::League.count} leagues\n"
  SportDb::Model::League.order( 'key' ).each do |league|
    buf << "#{league.key} - #{league.name} |  #{league.events.count} events\n"   ## todo: list years? why? why not??
  end
  buf
end

def build_seasons
  buf = ''
  buf << "#{SportDb::Model::Season.count} seasons\n"
  SportDb::Model::Season.order('name desc').each do |season|
    buf << "#{season.name} |  #{season.events.count} events\n"     ## todo: list leagues? why? why not??
  end
  buf
end



def build_summary
  buf = ''
  ## todo/fix: show national, clubs count etc.
  ##  group by country ??
  buf << "#{SportDb::Model::Team.count} teams, #{SportDb::Model::Match.count} matches\n"
  buf
end


def build_events
  buf = ''
  buf << "#{SportDb::Model::Event.count} events:\n"
  SportDb::Model::Season.order('name desc').each do |season|
    buf << "  #{season.name} (#{season.events.count}):\n"
    season.events.order('events.key').each do |event|
      buf << build_event( event )
    end
  end
  buf
end


def build_event( event )
  buf = ''
  buf << "== #{event.league.key} - #{event.name} "
  buf << "|  #{event.teams.count} Teams"
  buf << ", #{event.matches.count} Matches"

  score1 = event.matches.sum(:score1 )
  score2 = event.matches.sum(:score2 )
  score1et = event.matches.sum(:score1et )
  score2et = event.matches.sum(:score2et )

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
      buf << "#{round.pos} (#{round.matches.count})  "
    end
  end

  buf << "\n\n"
  buf
end
