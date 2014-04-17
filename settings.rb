
# input repo sources config

# --- world.db ---

OPENMUNDI_ROOT        = "../../openmundi"
WORLD_DB_INCLUDE_PATH = "#{OPENMUNDI_ROOT}/world.db"


# --- football.db ---

OPENFOOTBALL_ROOT = ".."

STADIUMS_INCLUDE_PATH  = "#{OPENFOOTBALL_ROOT}/stadiums" # stadiums
PLAYERS_INCLUDE_PATH   = "#{OPENFOOTBALL_ROOT}/players"  # players

#########################
# national teams

NATIONAL_TEAMS_INCLUDE_PATH         = "#{OPENFOOTBALL_ROOT}/national-teams"
WORLD_CUP_INCLUDE_PATH              = "#{OPENFOOTBALL_ROOT}/world-cup"
EURO_CUP_INCLUDE_PATH               = "#{OPENFOOTBALL_ROOT}/euro-cup"
AFRICA_CUP_INCLUDE_PATH             = "#{OPENFOOTBALL_ROOT}/africa-cup"
NORTH_AMERICA_GOLD_CUP_INCLUDE_PATH = "#{OPENFOOTBALL_ROOT}/north-america-gold-cup"
COPA_AMERICA_INCLUDE_PATH           = "#{OPENFOOTBALL_ROOT}/copa-america"

################
# clubs

WORLD_INCLUDE_PATH       = "#{OPENFOOTBALL_ROOT}/world"

AT_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/at-austria"
DE_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/de-deutschland"
EN_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/en-england"
ES_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/es-espana"
IT_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/it-italy"

EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH = "#{OPENFOOTBALL_ROOT}/europe-champions-league"

MX_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/mx-mexico"
BR_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/br-brazil"

NORTH_AMERICA_CHAMPIONS_LEAGUE_INCLUDE_PATH = "#{OPENFOOTBALL_ROOT}/north-america-champions-league"
COPA_LIBERTADORES_INCLUDE_PATH              = "#{OPENFOOTBALL_ROOT}/copa-libertadores"
COPA_SUDAMERICANA_INCLUDE_PATH              = "#{OPENFOOTBALL_ROOT}/copa-sudamericana"

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
  ['WORLD',   WORLD_INCLUDE_PATH],
  ['AT',      AT_INCLUDE_PATH],
  ['DE',      DE_INCLUDE_PATH],
  ['EN',      EN_INCLUDE_PATH],
  ['ES',      ES_INCLUDE_PATH],
  ['IT',      IT_INCLUDE_PATH],
  ['EUROPE_CHAMPIONS_LEAGUE', EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH],
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
