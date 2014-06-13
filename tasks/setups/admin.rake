
# - test sport.db.admin setup
task :admin => [:importbuiltin, :grounds] do
  ########
  # national teams

  SportDb.read_setup( 'setups/all',    NATIONAL_TEAMS_INCLUDE_PATH )

  SportDb.read_setup( 'setups/2012',   EURO_CUP_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2014',   WORLD_CUP_INCLUDE_PATH )

  ################
  # clubs

  SportDb.read_setup( 'setups/all',  WORLD_INCLUDE_PATH )

  SportDb.read_setup( 'setups/2013_14',  AT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  DE_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  EN_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  ES_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  IT_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013_14',  EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH )

##  SportDb.read_setup( 'setups/2013_14', MX_INCLUDE_PATH )
## fix:
##   [info] parsing data 'mx-mexico!/2013/clausura' (../mx-mexico/2013/clausura.yml)...
# ActiveRecord::RecordNotFound: Couldn't find SportDb::Model::Team with key = sanluis

  SportDb.read_setup( 'setups/2013_14', NORTH_AMERICA_CHAMPIONS_LEAGUE_INCLUDE_PATH )

##
## fix:
##   deprecated manifest/setup format [SportDb.Reader]; use new plain text format
# [info] parsing data 'setups/2013_14' (../north-america-champions-league/setups/2013_14.yml)...
# Errno::ENOENT: No such file or directory - ../north-america-champions-league/setups/2013_14.yml

  SportDb.read_setup( 'setups/2013',    BR_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2013',    COPA_LIBERTADORES_INCLUDE_PATH )

  ## fix: include club-world-cup - moved to its own repo
  ## SportDb.read_setup( 'setups/2013',   WORLD_INCLUDE_PATH )  # circular reference; requires other teams
end
