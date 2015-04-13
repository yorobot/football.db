
task :clubs => :importbuiltin do
  ## todo/fix: add es,it,at too!!!
  football 'eng-england',    setup: 'teams'
  football 'de-deutschland', setup: 'teams'
  football 'mx-mexico',      setup: 'teams'
  football 'br-brazil',      setup: 'teams'
  football 'clubs'
end

