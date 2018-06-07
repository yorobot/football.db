

task :worldcup2018 => :importbuiltin do
  SportDb.read_setup( 'setups/all',  STADIUMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all',  NATIONAL_TEAMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/2018', WORLD_CUP_INCLUDE_PATH )

  ## add GroupStanding
  ## event = SportDb::Model::Event.find_by( key: 'world.2018' )
  ## event.groups.each do |group|
  ##   SportDb::Model::GroupStanding.create!( group_id: group.id )
  ## end

  SportDb::Model::GroupStanding.recalc!
end



task :recalc_worldcup2018 => :configsport do
  ## hack: auto-add GroupStanding / fix: use "generic" version for all world cups
  ## event = SportDb::Model::Event.find_by!( key: 'world.2018' )
  ## event.groups.each do |group|
  ##   SportDb::Model::GroupStanding.create!( group_id: group.id )
  ## end

  SportDb::Model::GroupStanding.recalc!
end


task :json_worldcup2018 => :configsport  do       ## for in-memory depends on all for now - ok??
  out_root = debug? ? './build' : WORLD_CUP_JSON_REPO_PATH

  gen_json_worldcup( 'world',   out_root: out_root )
end
