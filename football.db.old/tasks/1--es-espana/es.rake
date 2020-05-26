

task :es => :importbuiltin do
  SportDb.read_setup( 'setups/all', ES_INCLUDE_PATH )
end

## for testing (new) 2017/18 season
##  use:
##   rake clean create importworld es18
task :es18 => :importbuiltin do
  SportDb.read_setup( 'setups/2017-18', ES_INCLUDE_PATH )

  out_root = debug? ? './build/es-espana' : ES_INCLUDE_PATH

  ['es.2017/18'].each do |event_key|
     recalc_standings( event_key, out_root: out_root  )
     ## recalc_stats( out_root: out_root )
  end
end




task :recalc_es => :configsport do
  out_root = debug? ? './build/es-espana' : ES_INCLUDE_PATH

  ['es.2012/13',
   'es.2013/14',
   'es.2014/15',
   'es.2015/16',
   'es.2016/17',
   'es.2017/18'].each do |event_key|
     recalc_standings( event_key, out_root: out_root )
     ## recalc_stats( out_root: out_root )
  end
end
