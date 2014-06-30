##########################
# paths

NATIONAL_TEAMS_PATHS = [
  ['NATIONAL_TEAMS',         NATIONAL_TEAMS_INCLUDE_PATH],
  ['WORLD_CUP',              WORLD_CUP_INCLUDE_PATH],
  ['EURO_CUP',               EURO_CUP_INCLUDE_PATH],
  ['AFRICA_CUP',             AFRICA_CUP_INCLUDE_PATH], 
  ['NORTH_AMERICA_GOLD_CUP', NORTH_AMERICA_GOLD_CUP_INCLUDE_PATH],
  ['COPA_AMERICA',           COPA_AMERICA_INCLUDE_PATH]
]

CLUBS_PATHS = [
  ['CLUBS',   CLUBS_INCLUDE_PATH],
  ['AT',      AT_INCLUDE_PATH],
  ['DE',      DE_INCLUDE_PATH],
  ['EN',      EN_INCLUDE_PATH],
  ['ES',      ES_INCLUDE_PATH],
  ['IT',      IT_INCLUDE_PATH],
  ['EUROPE_CHAMPIONS_LEAGUE', EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH],
  ['MLS',     MLS_INCLUDE_PATH],
  ['MX',      MX_INCLUDE_PATH],
  ['BR',      BR_INCLUDE_PATH],
  ['NORTH_AMERICA_CHAMPIONS_LEAGUE', NORTH_AMERICA_CHAMPIONS_LEAGUE_INCLUDE_PATH],
  ['COPA_LIBERTADORES',              COPA_LIBERTADORES_INCLUDE_PATH],
  ['COPA_SUDAMERICANA',              COPA_SUDAMERICANA_INCLUDE_PATH]
]


ALL_REPO_PATHS = [
  ['WORD_DB', WORLD_DB_INCLUDE_PATH ],
  ['STADIUMS', STADIUMS_INCLUDE_PATH],
  ['PLAYERS',  PLAYERS_INCLUDE_PATH]] +
  NATIONAL_TEAMS_PATHS +
  CLUBS_PATHS


def check_repo_paths( ary )
  puts "checking repo paths..."

  ary.each do |entry|
    name = entry[0]
    path = entry[1]

    if Dir.exists?( path )    ## note: same as File.directory?()
      print '  OK               '
    else
      print '  -- NOT FOUND --  '
    end
    print " %-30s <%s>\n" % [name,path]
  end
end


desc 'check repo paths'
task :check  do
  check_repo_paths( ALL_REPO_PATHS )
end
