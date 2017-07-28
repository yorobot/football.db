# encoding: utf-8


## update all repos (using git pull)
task :pull do
  repos = OPENFOOTBALL_PATHS     ## see settings.rb

  puts "Dir.getwd: #{Dir.getwd}" 
  repos.each do |repo|
    Dir.chdir( repo ) do      
      ## trying to update
      puts ''
      puts "###########################################"
      puts "## trying to update #{repo}"
      puts "Dir.getwd: #{Dir.getwd}" 
      result = system( "git status" )
      result = system( "git pull" )
      ## todo: check return code
    end
 end
 puts "Dir.getwd: #{Dir.getwd}" 
end


## commit and push all repos
task :push do
  repos = OPENFOOTBALL_PATHS   ## see settings.rb

  ## todo/fix:
  ##  check if any changes (only push if changes commits - how??)

  puts "Dir.getwd: #{Dir.getwd}" 
  repos.each do |repo|
    Dir.chdir( repo ) do      
      ## trying to update
      puts ''
      puts "###########################################"
      puts "## trying to commit and push #{repo}"
      puts "Dir.getwd: #{Dir.getwd}" 
      result = system( "git status" )
      pp result
      result = system( "git add .")
      pp result
      result = system( %Q{git commit -m "up standings"} )
      pp result
      result = system( "git push" )
      pp result
      ## todo: check return code
    end
 end
 puts "Dir.getwd: #{Dir.getwd}" 
end

