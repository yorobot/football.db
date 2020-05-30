##
# note:
#  on windows use:
#    $ sh ./build.sh     -- requires unix shell (e.g. cygnus)


## echo "Pull in changes from remote repos"
## rake pull
ruby ./setup.rb

## note:
##    stats are global for database, thus, for now rebuild database for every setup/repo

echo "Build database, standings, stats, etc."
rake build lint stats recalc DATA=at
rake build lint stats recalc DATA=de
rake build lint stats recalc DATA=en
rake build lint stats recalc DATA=es
rake build lint stats recalc DATA=it
rake build lint stats recalc DATA=fr

## rake build recalc DATA=ru    -- not working e.g. date [] missing


## rake push