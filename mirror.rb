####
#  mirror england datasets - export to csv

require_relative 'boot'

require 'fileutils'



## todo/fix:  reuse  a "original" CsvMatchWriter - how? why? why not?
module Mirror
class CsvMatchWriter

    def self.write( path, recs, headers: )

      ## for convenience - make sure parent folders/directories exist
      FileUtils.mkdir_p( File.dirname( path ))  unless Dir.exist?( File.dirname( path ))

        File.open( path, 'w:utf-8' ) do |f|
          f.write headers.join(',')   ## e.g. Date,Team 1,FT,HT,Team 2
          f.write "\n"
          recs.each do |rec|
              f.write rec.join(',')
              f.write "\n"
          end
        end
    end

end # class CsvMatchWriter
end # module Cache




def mirror( dbname:   'en',
            reponame: 'england'
          )

SportDb.connect( adapter:  'sqlite3',
                 database: "./build/#{dbname}.db" )
SportDb.tables


SportDb::Model::Event.order( :id ).each do |event|
  ## note: in eng - skip playoffs for now e.g. eng.playoffs.2, eng.playoffs.3 etc.
  ## note: in de  - skip DFB Pokal (de.cup) and Relegation (de.rel) for now
  next if event.league.key.start_with?( 'eng.playoffs' )
  next if event.league.key.start_with?( 'de.rel' )
  next if event.league.key.start_with?( 'de.cup' )


  puts "write #{event.league.key} - #{event.season.key}"

  recs = []
  event.rounds.each do |round|
     matchday = if round.name =~ /(?:Round|Matchday|Spieltag) ([0-9]+)/
                  $1
                else
                 puts "!! ERROR - invalid matchday format >#{round.name}<:"
                 pp round
                 exit 1

                 ## todo/check: just report errror (and continue) and set to '?' - why? why not?
                end
     round.matches.each do |match|
         ## todo/fix: add support for cancelled/canceled, awarded (awd.), etc.
         recs << [matchday,
                  match.date.strftime('%Y-%m-%d'),
                  match.team1.name,
                  match.score1 && match.score2 ? "#{match.score1}-#{match.score2}" : '',
                  match.team2.name]
     end
  end
  puts "     #{recs.size} records"

  headers = [
     'Matchday',
     'Date',
     'Team 1',
     'FT',
     'Team 2'
  ]

  basename = event.league.key
  season = Season.new( event.season.key )
  season_path = season.to_path( :archive )  ## e.g. 2010s/2010-11

  ## path = "./o/#{season_path}/#{basename}.csv"
  path = "../../footballcsv/#{reponame}/#{season_path}/#{basename}.csv"
  puts "  path=>#{path}<"

  ## sort by date
  recs = recs.sort { |l,r| l[1] <=> r[1] }
  ## reformat date / beautify e.g. Sat Aug 7 1993
  recs.each { |rec| rec[1] = Date.strptime( rec[1], '%Y-%m-%d' ).strftime( '%a %b %-d %Y' ) }

  Mirror::CsvMatchWriter.write( path, recs, headers: headers )
end
end # method mirror


## mirror( dbname: 'en', reponame: 'england' )
mirror( dbname: 'de', reponame: 'deutschland' )


puts "bye"