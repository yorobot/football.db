
task :europe_clubs => :importbuiltin do
  football 'clubs',     setup: 'teams'   ## use teams_europe ??
  football 'at-austria'
  football 'de-deutschland'
  football 'eng-england'
  football 'es-espana'
  football 'it-italy'
end

