

def dump_alltime_standings
  SportDb::Model::AlltimeStanding.order(:id).each do |st|
    puts "=========="
    puts "##  #{st.title}"
    dump_standing_entries( st.entries.order('pos') )
  end
end

def dump_standing_entries( entries )
  entries.each do |entry|
    buf = ''
    buf << '%2d  ' %  entry.pos
    buf << '%-26s  ' % "#{entry.team.title} (#{entry.team.code})"
    buf << '%3d  ' % entry.played
    buf << '%3d ' % entry.won
    buf << '%3d ' % entry.drawn
    buf << '%3d  ' % entry.lost
    buf << '%3d:%-3d  ' % [entry.goals_for,entry.goals_against]
    buf << '%3d  ' % entry.pts

    ## note: only alltime recs include recs field/attribute
    buf << '%2d'  % entry.recs     if entry.respond_to?( :recs )
    puts buf # end w/ newline
  end
end

