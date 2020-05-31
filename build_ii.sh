##
# note:
#  on windows use:
#    $ sh ./build.sh     -- requires unix shell (e.g. cygnus)


## echo "Pull in changes from remote repos"
## rake pull
## ruby ./setup.rb

## note:
##    stats are global for database, thus, for now rebuild database for every setup/repo

echo "Build database, standings, stats, etc."
rake build lint stats DATA=cl

rake build lint stats DATA=euro
rake build lint stats DATA=world

## rake push_all