
# - test sport.db.admin setup
task :admin => [:importbuiltin, :grounds] do

  ########
  # national teams

  football 'national-teams'

  football 'euro-cup',  setup: '2012'
  football 'world-cup', setup: '2014'

  ################
  # clubs

  football 'clubs'

  football 'at-austria',              setup: '2013_14'
  football 'de-deutschland',          setup: '2013_14'
  football 'eng-england',             setup: '2013_14'
  football 'es-espana',               setup: '2013_14'
  football 'it-italy',                setup: '2013_14'
  football 'europe-champions-league', setup: '2013_14'

##  SportDb.read_setup( 'setups/2013_14', MX_INCLUDE_PATH )
## fix:
##   [info] parsing data 'mx-mexico!/2013/clausura' (../mx-mexico/2013/clausura.yml)...
# ActiveRecord::RecordNotFound: Couldn't find SportDb::Model::Team with key = sanluis

  football 'north-america-champions-league', setup: '2013_14'

##
## fix:
##   deprecated manifest/setup format [SportDb.Reader]; use new plain text format
# [info] parsing data 'setups/2013_14' (../north-america-champions-league/setups/2013_14.yml)...
# Errno::ENOENT: No such file or directory - ../north-america-champions-league/setups/2013_14.yml

  football 'br-brazil',         setup: '2013'
  football 'copa-libertadores', setup: '2013'

  ## fix: include club-world-cup - moved to its own repo
  ## SportDb.read_setup( 'setups/2013',   CLUBS_INCLUDE_PATH )  # circular reference; requires other teams
end
