#########################
#  build updates.db (from scratch) using datasets in footballcsv/cache.updates

require_relative 'boot'



###############
#  setup database (from scratch)
DB_PATH = './build/updates.db'
File.delete( DB_PATH )  if File.exist?( DB_PATH )

SportDb.connect( adapter:  'sqlite3',
                 database: DB_PATH )
SportDb.create_all




## Shortcut convenience helpers
Model  = SportDb::Model
Sync   = SportDb::Sync
Import = SportDb::Import



UPDATES_DIR = "../../footballcsv/cache.updates"

datafiles = Dir[ "#{UPDATES_DIR}/**/*.csv" ]
puts "#{datafiles.size} datafiles"


## note: for now always assume 2019/20 season
season = Import::Season.new( '2019/20' )

datafiles.each do |datafile|

  ### todo/fix: !!!!!! change to CsvMatchParser.read !!!!!!!!!!
  ###   - add missing league column - why? why not?

  recs = CsvHash.read( datafile, :header_converters => :symbol )
  recs.each do |rec|

    basename = File.basename( datafile, File.extname( datafile ))
    print "add #{basename} -- #{rec[:league]} |"
    print " #{rec[:team_1]}  #{rec[:ft]}  #{rec[:team_2]}  |"
    print " #{rec[:date]}\n"

    league = LEAGUES.find!( rec[:league] )
    team1  = TEAMS.find_by!( name: rec[:team_1], league: league )
    team2  = TEAMS.find_by!( name: rec[:team_2], league: league )

    values = rec[:ft].split('-')
    score1 = values[0].to_i
    score2 = values[1].to_i

    # e.g. Sat Aug 7 1993
    date =  Date.strptime( rec[:date], '%a %b %d %Y' )
    pp date

    puts "  #{team1.name}  #{score1}-#{score2}  #{team2.name}"


    event_rec = Sync::Event.find_or_create_by( league: league,
                                               season: season )

    team1_rec = Sync::Team.find_or_create( team1 )
    team2_rec = Sync::Team.find_or_create( team2 )

    ## warn about duplicates?
    ##  note: for now only allow one (unique) match pair per team
    match_recs = Model::Match.where( event_id: event_rec.id,
                                    team1_id: team1_rec.id,
                                    team2_id: team2_rec.id ).to_a
    if match_recs.size > 0
      puts "!! #{match_recs.size} duplicate match record(s) found:"
      pp match_recs
      exit 1
    end

    ## find last pos - check if it can be nil?  yes, is nil if no records found
    max_pos = Model::Match.where( event_id: event_rec.id ).maximum( 'pos' )
    max_pos = max_pos ? max_pos+1 : 1

    rec = Model::Match.create!(
            event_id: event_rec.id,
            team1_id: team1_rec.id,
            team2_id: team2_rec.id,
            ## round_id: round_rec.id,  -- note: now optional
            pos:      max_pos,
            date:     date.to_date,
            score1:   score1,
            score2:   score2 )
  end
end


SportDb.tables   ## print some stats

