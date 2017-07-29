

def pretty_print_matrix( team_idx, matrix )  # pretty print matrix

   puts "team_idx (lookup by id):"
   pp team_idx

   puts "matrix:"
   pp matrix


   ### pretty print
   print "Home \\ Away        "
   team_idx.values.each do |t|
     print "%-3.3s" % t[2]   ## print code (min/max 3 letters - right padded)
     print "    "
   end
   print "\n"

   matrix.each_with_index do |row,i|
     t = team_idx.values[i]
     line =  "%.12s " % t[1]     ## print name (max 12 letters)
     line << "(%.3s)" % t[2]     ## print code (max 3 letters)
     print "%-18.18s " % line    ## print min/max 18 letters - right padded

     row.each_with_index do |score,j|
       if i == j
          print "%-5.5s" % ' *'    # home == away team
       else
         if score.nil?
           print "%-5.5s" % '??'
         else
           print "%-5.5s" % score
         end
       end
       print "  "
     end
     print "\n"
   end
end  # method pretty_print_matrix



def dump_matrix( event_key, out_root: )
  puts "  enter dump_matrix >#{event_key}< in (#{out_root})"

  event = SportDb::Model::Event.find_by_key!( event_key )
  puts event.title

  puts "teams: #{event.teams.count}"
  puts "rounds: #{event.rounds.count}"

  teams_count  = event.teams.count
  rounds_count = event.rounds.count


  ## calculate number of matrixes
  ##   e.g. 10 teams (10-1 = 9x2 = 18 rounds   -- needed for full matrix - home and away matches )
  ##        20 teams (20-1 = 19x2 = 38 rounds  -- needed for full matrix)


  team_idx = {}
  event.teams.each_with_index do |team,i|
    team_idx[ team.id ] = [i,team.name,team.code]
  end

  puts "team_idx (lookup by id):"
  pp team_idx


  matrix_rounds_count = (teams_count - 1)*2
  puts "matrix - no of rounds: #{matrix_rounds_count}"

  matrixes = []

  ## note: event might have more than one matrix (away and home rounds
  ##   e.g. 10 teams with 36 rounds = 2x full matrixes!!)
  event.rounds.each_slice( matrix_rounds_count ) do |rounds|
    puts "matrix:"
    matrix = Array.new(teams_count) { Array.new(teams_count) }   ## sort of ary[10][10]
    pp matrix

    matrixes << matrix

    rounds.each do |round|
      puts
      puts "** #{round.title}"
      round.games.each do |game|
        puts "  #{game.team1.name} - #{game.team2.name}"

        home = team_idx[game.team1.id]
        away = team_idx[game.team2.id]

        home_idx = home[0]  ## first array entry is the zero-based index (0-n)
        away_idx = away[0]
        score    = "#{game.score1}-#{game.score2}"

        puts "    adding [#{home_idx}][#{away_idx}]  #{score}"

        ## todo/fix: issue warning if NOT nil - do NOT overwrite!!!

        matrix[home_idx][away_idx] = score
      end  # each game
    end  # each round
  end  # each slice (of rounds)

  pp matrixes

  matrixes.each_with_index do |matrix,i|
    if matrixes.size > 1
      puts "#{i+1}/#{matrixes.size}:"
    end
    pretty_print_matrix( team_idx, matrix )
  end

end  # method dump matrix




task :at_matrix => :configsport do
  out_root = debug? ? './build/at-austria' : AT_INCLUDE_PATH

  dump_matrix( 'at.2016/17', out_root: out_root )
end
