

task :worldcup2018 => :importbuiltin do
  SportDb.read_setup( 'setups/all',  NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2018', WORLD_CUP_INCLUDE_PATH )
end


task :recalc_worldcup2018 => :configsport do
end


task :json_worldcup2018 => :configsport  do       ## for in-memory depends on all for now - ok??
  out_root = debug? ? './build' : WORLD_CUP_JSON_REPO_PATH

  gen_json_worldcup( 'world',   out_root: out_root )
end
