
# input repo sources config

# --- world.db ---

OPENMUNDI_ROOT        = "../../openmundi"
WORLD_DB_INCLUDE_PATH = "#{OPENMUNDI_ROOT}/world.db"




# --- football.db ---

OPENFOOTBALL_ROOT = "../../openfootball"

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

CLUBS_INCLUDE_PATH       = "#{OPENFOOTBALL_ROOT}/clubs"

AT_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/at-austria"
DE_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/de-deutschland"
ENG_INCLUDE_PATH         = "#{OPENFOOTBALL_ROOT}/eng-england"       ## Note: changed to ENG_INCLUDE_... (from EN_)
ES_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/es-espana"
IT_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/it-italy"
FR_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/fr-france"
RU_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/ru-russia"
CH_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/ch-confoederatio-helvetica"


### todo/fix: add more path - used by ???
OPENFOOTBALL_PATHS = [
  AT_INCLUDE_PATH,
  DE_INCLUDE_PATH,
  ENG_INCLUDE_PATH,
  ES_INCLUDE_PATH,
  IT_INCLUDE_PATH,
###  RU_INCLUDE_PATH,
]




EUROPE_CHAMPIONS_LEAGUE_INCLUDE_PATH = "#{OPENFOOTBALL_ROOT}/europe-champions-league"

MLS_INCLUDE_PATH         = "#{OPENFOOTBALL_ROOT}/major-league-soccer"   # us-united-states n ca-canada
MX_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/mx-mexico"
BR_INCLUDE_PATH          = "#{OPENFOOTBALL_ROOT}/br-brazil"

NORTH_AMERICA_CHAMPIONS_LEAGUE_INCLUDE_PATH = "#{OPENFOOTBALL_ROOT}/north-america-champions-league"
COPA_LIBERTADORES_INCLUDE_PATH              = "#{OPENFOOTBALL_ROOT}/copa-libertadores"
COPA_SUDAMERICANA_INCLUDE_PATH              = "#{OPENFOOTBALL_ROOT}/copa-sudamericana"
