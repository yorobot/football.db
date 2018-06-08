
task :worldcup_base => :importbuiltin do
  SportDb.read_setup( 'setups/all', ASSOCS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', STADIUMS_INCLUDE_PATH )
  SportDb.read_setup( 'setups/all', NATIONAL_TEAMS_INCLUDE_PATH )
end


task :worldcup2018 => :worldcup_base do
  SportDb.read_setup( 'setups/2018', WORLD_CUP_INCLUDE_PATH )
end

task :worldcup2014 => :worldcup_base do
  SportDb.read_setup( 'setups/2014', WORLD_CUP_INCLUDE_PATH )
end


task :worldcup => [:worldcup2018,:worldcup2014] do
end



task :recalc_worldcup => :configsport do
  ## hack: auto-add GroupStanding / fix: use "generic" version for all world cups
  ['world.2018', 'world.2014'].each do |key|
    event = SportDb::Model::Event.find_by!( key: key )
    event.groups.each do |group|
       standing = SportDb::Model::GroupStanding.find_or_create_by!( group_id: group.id )
       pp standing

       calc = SportDb::Standings.new
       calc.setup( group.teams )
       calc.update( group.games )

       ## - remove (if exit) old entries and add new entries
       standing.entries.delete_all

       ## add empty entries
       calc.to_a.each do |rec|
         puts "   adding entry for team #{rec.team_name}"
         standing.entries.create!(
                team_id: SportDb::Model::Team.find_by!( title: rec.team_name ).id,
                pos:     rec.rank,
                played:  rec.played,
                won:     rec.won,
                drawn:   rec.drawn,
                lost:    rec.lost,
                goals_for: rec.goals_for,
                goals_against: rec.goals_against,
                pts:     rec.pts  )
      end
     end
  end
end


task :json_worldcup => :configsport  do       ## for in-memory depends on all for now - ok??
  out_root = debug? ? './build' : WORLD_CUP_JSON_REPO_PATH

  gen_json_worldcup( 'world',   out_root: out_root )
end
