#####################
# national teams

task :eurocup => :importbuiltin do
  football 'openfootball/national-teams'
  football 'openfootball/euro-cup'
end

