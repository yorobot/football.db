

desc 'print matches stats (for checksum mostly)'
task :matches_stats => :env do

  SportDb::Model::Event.joins(:season).order('seasons.title desc').each do |event|
    buf = ''
    buf << "#{event.season.title} #{event.league.title}  "
    buf << "|  #{event.teams.count}  "
    buf << "|  #{event.games.count}  "

    score1 = event.games.sum(:score1)
    score2 = event.games.sum(:score2)
    score  = score1 + score2

    ## note:
    ##  for extra time (only add diff e.g. score1et-score1
    ##    otherwise regular time (90min)goals get added twice!!
    diff_score1et = event.games.sum( 'coalesce(score1et-score1,0)' )
    diff_score2et = event.games.sum( 'coalesce(score2et-score2,0)' )
    diff_scoreet = diff_score1et + diff_score2et

    ## check/todo: add penalty (shootout) too? - skip for now

    buf << "|  #{score+diff_scoreet} (+#{diff_scoreet} a.e.t.)"

    puts buf
  end
end

