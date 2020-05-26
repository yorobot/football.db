########################################################
# major league soccer (mls) - united states n canada

task :mls => :importbuiltin do
  SportDb.read_setup( 'setups/all',   MLS_INCLUDE_PATH )
end

