

task :it => :importbuiltin do
  SportDb.read_setup( 'setups/all', IT_INCLUDE_PATH )
end


task :recalc_it => :configsport do
  out_root = debug? ? './build/it-italy' : IT_INCLUDE_PATH

  ['it.2013/14',
   'it.2014/15',
   'it.2015/16',
   'it.2016/17'].each do |event_key|
     recalc_standings( event_key, out_root: out_root )
     ## recalc_stats( out_root: out_root )
  end
end
