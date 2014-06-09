

desc 'print matches stats (for checksum mostly)'
task :matches_stats => :env do

  SportDb::Model::Event.joins(:season).order('seasons.title desc').each do |event|
    buf = ''
    buf << "#{event.season.title} #{event.league.title}  "
    buf << "|  #{event.teams.count}  "
    buf << "|  #{event.games.count}  "
    
    score1 = event.games.sum(:score1 )
    score2 = event.games.sum(:score2 )
    score1et = event.games.sum(:score1et )
    score2et = event.games.sum(:score2et )

    ## check/todo: add penalty (shootout) too? - skip for now

    buf << "|  #{score1+score2+score1et+score2et} (+#{score1et+score2et} a.e.t.)"

    puts buf
  end
end

