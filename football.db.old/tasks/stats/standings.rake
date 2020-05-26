
desc 'print standings for football.db (test/debug)'
task :standings => :env do

  # recalc world cup
  # st = SportDb::Model::AlltimeStanding.create!( key: 'world', title: 'All Time World Cup' )
  # st.recalc_for_league!( SportDb::Model::League.find_by_key!( 'world') )

  # st = SportDb::Model::EventStanding.create!( event: SportDb::Model::Event.find_by_key!( 'world.2006'))
  # st.recalc!

  # ev = SportDb::Model::Event.find_by_key!( 'world.2010')
  #ev.groups.each do |g|
  #  st = SportDb::Model::GroupStanding.create!( group: g )
  #  st.recalc!
  #end

  # dump alltime standings
  dump_alltime_standings()

  # dump event standings
  SportDb::Model::EventStanding.order(:id).each do |st|
    puts "=========="
    puts "  Event -  #{st.event.title}"
    dump_standing_entries( st.entries.order('pos') )
  end

  # dump group standings
  SportDb::Model::GroupStanding.order(:id).each do |st|
    puts "=========="
    puts "  Group  #{st.group.pos} / #{st.group.event.title}"
    dump_standing_entries( st.entries.order('pos') )
  end

end

