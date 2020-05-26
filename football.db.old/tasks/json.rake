

task :json => :configsport  do       ## for in-memory depends on all for now - ok??
  out_root = debug? ? './build' : JSON_REPO_PATH 

  gen_json( 'at',   out_root: out_root )
  gen_json( 'at.2', out_root: out_root )
  gen_json( 'de',   out_root: out_root )
  gen_json( 'de.2', out_root: out_root )
  gen_json( 'en',   out_root: out_root )
  gen_json( 'es',   out_root: out_root )
  gen_json( 'it',   out_root: out_root )
end

