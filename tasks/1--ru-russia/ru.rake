

task :ru => :importbuiltin do
  SportDb.read_setup( 'setups/all', RU_INCLUDE_PATH )
end


task :recalc_ru => :configsport do
  out_root = debug? ? './build/ru-russia' : RU_INCLUDE_PATH

  ['ru.2015/16'].each do |event_key|
     recalc_standings( event_key, out_root: out_root )
     ## recalc_stats( out_root: out_root )
  end
end
