############################
# todo: squads - move to worldcup.rake ??

task :squads => :players do
  ## test/try squads for worldcup 2014
  ## add importbuiltin dep too (or reuse from players) ?? why? why not??

  football 'national-teams'
  football 'world-cup',     setup: '2014_squads'
end

