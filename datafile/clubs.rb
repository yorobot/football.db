
task :clubs => :importbuiltin do
  ## todo/fix: add es,it,at too!!!
  football 'openfootball/eng-england',    setup: 'teams'
  football 'openfootball/de-deutschland', setup: 'teams'
  football 'openfootball/mx-mexico',      setup: 'teams'
  football 'openfootball/br-brazil',      setup: 'teams'
  football 'openfootball/clubs'
end

