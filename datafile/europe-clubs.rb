
task :europe_clubs => :importbuiltin do
  football 'openfootball/clubs',     setup: 'teams'   ## use teams_europe ??
  football 'openfootball/at-austria'
  football 'openfootball/de-deutschland'
  football 'openfootball/eng-england'
  football 'openfootball/es-espana'
  football 'openfootball/it-italy'
end

