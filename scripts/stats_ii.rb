


LeagueTeamStat = Struct.new( :key, :name, :seasons )


def build_leagues( keys=nil )
  ## default to all keys if none passed in
  keys = SportDb::Model::League.order( 'key' ).map {|rec| rec.key }  if keys.nil?

  buf = ""
  keys.each do |key|
    buf << build_league( key )
    buf << "\n\n"
  end
  buf
end

def build_league( key )   ## all events (e.g. seasons)
  buf = ""
  puts "find league >#{key}<"
  league = SportDb::Model::League.find_by!( key: key )
  count = league.events.count
  buf << "  #{league.name} - #{count} records\n"

  stats = {}

  ## todo/fix: use/change order to season.key - possible? why? why not?
  ##  .order( 'event.name DESC' )
  league.events.each do |event|
    buf << "    #{event.name}  - teams: #{event.teams.count},"
    buf << " matches: #{event.matches.count},"
    buf << " rounds: #{event.rounds.count}"
    buf << "\n"

    event.teams.each do |team|
      stat = stats[team.key] || LeagueTeamStat.new( team.key, team.name, [] )
      stat.seasons << event.season.key
      stats[team.key] = stat
    end
  end

  team_stats = stats.values.sort do |l,r|
    value =  r.seasons.size <=> l.seasons.size
    value =  l.name    <=> r.name      if value == 0
    value
  end

  ## pp team_stats

  ## print/dump reports
  buf << "\n"
  buf << "#{league.name}  - #{league.events.count} seasons\n"
  buf << "\n"
  team_stats.each_with_index do |stat,i|
    stat.seasons = stat.seasons.sort { |l,r| r<=>l }   ## sort season desc
    buf << " %2d. %-24s  %2d  (%s)\n" %  [i+1, stat.name, stat.seasons.size, stat.seasons.join(', ')]
  end

  team_stats

  buf
end



TeamStat       = Struct.new( :key, :name, :leagues, :seasons_count )
TeamLeagueStat = Struct.new( :key, :name, :seasons )


def build_teams_by_leagues( league_keys=nil )
  ## default to all keys if none passed in
  league_keys = SportDb::Model::League.order( 'key' ).map {|rec| rec.key }  if league_keys.nil?

  buf = ""
  stats = {}

  league_keys.each do |league_key|
    league = SportDb::Model::League.find_by!( key: league_key )
    count = league.events.count
    buf << "  #{league.name} - #{count} records\n"


    league.events.each do |event|
      buf << "    #{event.name}  -- teams: #{event.teams.count},"
      buf << " matches: #{event.matches.count},"
      buf << " rounds: #{event.rounds.count}"
      buf << "\n"

      event.teams.each do |team|
        team_stat    = stats[team.key] || TeamStat.new( team.key, team.name, {}, 0 )
        team_stat.seasons_count += 1
        league_stat  = team_stat.leagues[league.key] || TeamLeagueStat.new( league.key, league.name, [] )
        league_stat.seasons << event.season.key

        team_stat.leagues[league.key] = league_stat
        stats[team.key]       = team_stat
      end
    end
    buf << "\n"
  end


  team_stats = stats.values.sort do |l,r|
    value =  r.seasons_count <=> l.seasons_count
    value =  l.name    <=> r.name      if value == 0
    value
  end

  ## print/dump reports
  buf << "\n"
  buf << "#{team_stats.size} Clubs\n"
  buf << "\n"
  team_stats.each_with_index do |team_stat,i|
    buf << " %3d. %-24s\n" % [i+1, team_stat.name]
    team_stat.leagues.values.each do |league_stat|
      league_stat.seasons = league_stat.seasons.sort { |l,r| r<=>l }   ## sort season desc
      buf << "      - %-24s  %2d  (%s)\n" %  [league_stat.name, league_stat.seasons.size, league_stat.seasons.join(', ')]
    end
  end

  team_stats
  buf
end
