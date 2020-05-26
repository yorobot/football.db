#####################
# national teams

task :eurocup => :importbuiltin do
  football 'national-teams'
  football 'euro-cup'
end

