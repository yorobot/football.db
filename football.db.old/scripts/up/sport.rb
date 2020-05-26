# encoding: utf-8



def find_files( repo_root, pattern: '**/*.txt', names: nil )
  ## note: for now always filter by .yml extension
  
  if names
    names_regex = /#{names}/
  else
    names_regex = nil
  end

  
  files = nil
  
  Dir.chdir( repo_root ) do
 
    ## note: allow multiple patterns e.g. **/clubs/*.txt|**/clubs_*.txt
    ##  split by pipe (not comma already used by {p,q} )
  
    files = Dir[ pattern ]

    puts "before filter:"
    pp files

    files = files.select do |f|

      basename = File.basename( f )    # e.g. 1-bundesliga.yml  (note: incl. extension)
      dirname  = File.dirname( f )   # note: add trailing slash
      dirname = "#{dirname}/"

      puts "  basename=>#{basename}<, dirname=>#{dirname}<"

=begin
      if @path_regex
        match_dirname =  @path_regex === dirname    # note: use === (triple) for true/false regex match
      else
        match_dirname = true
      end
      match_basename && match_dirname
=end      

      if names_regex
        match_basename =  names_regex === basename
      else
        match_basename = true
      end


      match_basename
    end

    puts "after filter:"
    pp files
  end  ## Dir.chdir
  files
end # method find_files



Season = SportDb::Model::Season
Event  = SportDb::Model::Event
League = SportDb::Model::League

def add_seasons( years )
  ## note: assume active database connection

  ## e.g. 1964   => 1963/64
  ##      2011   => 2010/11   etc.
  
  ## todo:
  ##  use 2000   => 1999/00  ??  or 1999/2000 ??   
  
  years.each do |year|
    year_prev   = year-1
    season_key  =  "%4d/%02d" % [year_prev, year%100]   ## e.g. 1974/75

    season = Season.find_by( key: season_key )
    if season.nil?
      ## add if missing
      puts "   add season >#{season_key}<"
      Season.create!( key: season_key, title: season_key )
    end 
  end
end


def read_events( repo_root, fixtures )
  ## note: assume active database connection

  fixtures.each do |fx|
    path = "#{repo_root}/#{fx}"

    puts "path: >#{path}<"
    r = SportDb::EventReader.from_file( path )   ## note: reads .yml
    r.read  
  end
end

def read_table_events( repo_root, fixtures )
  ## note: assume active database connection

  fixtures.each do |fx|
    path = "#{repo_root}/#{fx}"

    puts "path: >#{path}<"
    r = SportDb::EventTableReader.from_file( path )   ## note: reads .yml
    r.read  
  end
end

def read_teams_for_country( cc, repo_root, fixtures )
  country = WorldDb::Model::Country.find_by!( key: cc )

  fixtures.each do |fx|
    path = "#{repo_root}/#{fx}"

    puts "path: >#{path}<"
    r = SportDb::TeamReader.from_file( path, country_id: country.id )
    r.read
  end
end


LeagueTeamStat = Struct.new( :key, :name, :seasons )

def dump_league( key )   ## all events (e.g. seasons)
  league = League.find_by!( key: key )
  count = league.events.count
  puts "  Found #{count} records -- #{league.title}"
  
  stats = {}
  
  league.events.each do |event|
    puts "  #{event.title}  -- teams: #{event.teams.count}"

    event.teams.each do |team|
      stat = stats[team.key] || LeagueTeamStat.new( team.key, team.title, [] )
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
  puts
  puts "#{league.title}  -- #{league.events.count} seasons"
  puts 
  team_stats.each_with_index do |stat,i|
    stat.seasons = stat.seasons.sort { |l,r| r<=>l }   ## sort season desc
    puts " %2d. %-24s  %2d  (%s)" %  [i+1, stat.name, stat.seasons.size, stat.seasons.join(', ')] 
  end
  
  team_stats
end



TeamStat       = Struct.new( :key, :name, :leagues, :seasons_count )
TeamLeagueStat = Struct.new( :key, :name, :seasons )

def dump_teams( league_keys )

  stats = {}
 
  league_keys.each do |league_key|
    league = League.find_by!( key: league_key )
    count = league.events.count
    puts "  Found #{count} records -- #{league.title}"
  
  
    league.events.each do |event|
      puts "  #{event.title}  -- teams: #{event.teams.count}"

      event.teams.each do |team|
        team_stat    = stats[team.key] || TeamStat.new( team.key, team.title, {}, 0 )
        team_stat.seasons_count += 1
        league_stat  = team_stat.leagues[league.key] || TeamLeagueStat.new( league.key, league.title, [] )
        league_stat.seasons << event.season.key
        
        team_stat.leagues[league.key] = league_stat
        stats[team.key]       = team_stat
      end
    end
  end
  
  team_stats = stats.values.sort do |l,r|
    value =  r.seasons_count <=> l.seasons_count
    value =  l.name    <=> r.name      if value == 0
    value
  end

  ## print/dump reports
  puts
  puts "#{team_stats.size} Clubs"
  puts 
  team_stats.each_with_index do |team_stat,i|
    puts " %3d. %-24s" % [i+1, team_stat.name]
    team_stat.leagues.values.each do |league_stat|
      league_stat.seasons = league_stat.seasons.sort { |l,r| r<=>l }   ## sort season desc
      puts "      - %-24s  %2d  (%s)" %  [league_stat.name, league_stat.seasons.size, league_stat.seasons.join(', ')] 
    end    
  end

  team_stats
end


