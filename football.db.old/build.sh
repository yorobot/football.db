##
# note:
#  on windows use:
#    $ sh ./build_all     -- requires unix shell (e.g. cygnus)


## echo "Pull in changes from remote repos"
## rake pull

## note:
##    stats are global for database, thus, for now rebuild database for every setup/repo

echo "Build database, standings, stats, etc."
rake build recalc DATA=at
rake build recalc DATA=de
rake build recalc DATA=en
rake build recalc DATA=es
rake build recalc DATA=it

## rake build recalc DATA=ru    -- not working e.g. date [] missing


