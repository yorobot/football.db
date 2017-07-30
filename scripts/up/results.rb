
def pretty_print_results_matrix( team_idx, matrix )  # pretty print results matrix / table

   puts "team_idx (lookup by id):"
   pp team_idx

   puts "matrix:"
   pp matrix


   # w == width; make it smaller for more than 20+ teams
   if team_idx.size >= 20
     w = 4
   else
     w = 5
   end

   buf = ""

   ### pretty print
   line = "Home \\ Away        "
   team_idx.values.each do |t|
     line << "%-#{w}.#{w}s" % t[2]   ## print code (min/max 3 letters - right padded)
   end
   line = line.strip    ## strip trailing spaces (to keep it compact)
   line << "\n"
   buf << line

   matrix.each_with_index do |row,i|
     t = team_idx.values[i]
     name =  "%.12s " % t[1]     ## print name (max 12 letters)
     name << "(%.3s)" % t[2]     ## print code (max 3 letters)

     line = "%-18.18s " % name    ## print min/max 18 letters - right padded

     row.each_with_index do |score,j|
       if i == j
          line << "%-#{w}.#{w}s" % ' *'    # home == away team
       else
         if score.nil?
           line << "%-#{w}.#{w}s" % '??'
         else
           line << "%-#{w}.#{w}s" % score
         end
       end
     end
     line = line.strip    ## strip trailing spaces (to keep it compact)
     line << "\n"
     buf << line
   end
   buf
end  # method pretty_print_results_matrix



def build_results_matrices( event_key )
  puts "  enter build_results_matrices >#{event_key}<"

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

  matrices = []

  ## note: event might have more than one matrix (away and home rounds
  ##   e.g. 10 teams with 36 rounds = 2x full matrixes!!)
  event.rounds.each_slice( matrix_rounds_count ) do |rounds|
    puts "matrix:"
    matrix = Array.new(teams_count) { Array.new(teams_count) }   ## sort of ary[10][10]
    pp matrix

    matrices << matrix

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

  pp matrices

  buf = ''

  matrices.each_with_index do |matrix,i|
    if matrices.size > 1
      buf << "#{i+1}/#{matrices.size}:"
      buf << "\n"
    end
    buf << pretty_print_results_matrix( team_idx, matrix )
    buf << "\n"
  end

  buf
end  # method build_results_matrices
