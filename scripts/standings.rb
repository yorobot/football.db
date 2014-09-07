# encoding: utf-8


def recalc_standings( event_key, opts={} )

  out_root = opts[:out_root] || './build'

  event = SportDb::Model::Event.find_by_key!( event_key )

  standings = SportDb::Standings.new
  standings.update( event.games )

  buf = build_standings( standings )
  pp buf

  segment = event.season.title.tr('/', '-')  ## change 2014/15 to 2014-15
  out_path = "#{out_root}/#{segment}/README.md"
  puts "out_path=>>#{out_path}<<, segment=>>#{segment}<<"

  ## make sure parent folders exist
  FileUtils.mkdir_p( File.dirname(out_path) ) unless Dir.exists?( File.dirname( out_path ))

  File.open( out_path, 'w' ) do |out|
    out.puts "\n\n"
    out.puts "### Standings\n"
    out.puts "\n"
    out.puts buf
    out.puts "\n"
    out.puts "\n"
    out.puts "---\n"
    out.puts "Pld = Matches; W = Matches won; D = Matches drawn; L = Matches lost; F = Goals for; A = Goals against; +/- = Goal differencence; Pts = Points\n"
    out.puts "\n"
  end

end


def build_standings( standings )
  buf = ""

  buf << "\n"
  buf << "~~~\n"
  buf << "                                        - Home -          - Away -            - Total -\n"
  buf << "                                 Pld   W  D  L   F:A     W  D  L   F:A      F:A   +/-  Pts\n"

  standings.to_a.each do |l|
    buf << '%2d. '  % l.rank
    buf << '%-28s  ' % l.team_name
    buf << '%2d  '     % l.played

    buf << '%2d '      % l.home_won
    buf << '%2d '      % l.home_drawn
    buf << '%2d '      % l.home_lost
    buf << '%3d:%-3d  ' % [l.home_goals_for,l.home_goals_against]

    buf << '%2d '       % l.away_won
    buf << '%2d '       % l.away_drawn
    buf << '%2d '       % l.away_lost
    buf << '%3d:%-3d  ' % [l.away_goals_for,l.away_goals_against]

    buf << '%3d:%-3d ' % [l.goals_for,l.goals_against]

    goals_diff = l.goals_for-l.goals_against
    if goals_diff > 0
      buf << '%3s  '  %  "+#{goals_diff}"
    elsif goals_diff < 0
      buf << '%3s  '  %  "#{goals_diff}"
    else ## assume 0
      buf << '     '
    end

    buf << '%3d'       % l.pts
    buf << "\n"
  end

  buf << "~~~\n"
  buf << "\n"
  ### buf << "(Source: `#{File.basename(in_path_csv)}`)\n"
  buf << "\n"
end
