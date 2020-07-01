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





SportDb.connect( adapter:  'sqlite3',
                 database: './build/en.db' )
SportDb.tables


SportDb::Model::Event.order( :id ).each do |event|
  ## note: skip playoffs for now e.g. eng.playoffs.2, eng.playoffs.3 etc.
  next if event.league.key.start_with?( 'eng.playoffs' )


  puts "write #{event.league.key} - #{event.season.key}"

  recs = []
  event.rounds.each do |round|
     matchday = if round.name =~ /(?:Round|Matchday) ([0-9]+)/
                  $1
                else
                 ## todo/fix: report errror!!
                 '?'
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
  season = SportDb::Import::Season.new( event.season.key )
  decade = "%3d0s" % [season.start_year/10]
  ## path = "./o/#{decade}/#{season.path}/#{basename}.csv"
  path = "../../footballcsv/england/#{decade}/#{season.path}/#{basename}.csv"
  puts "  path=>#{path}<"

  ## sort by date
  recs = recs.sort { |l,r| l[1] <=> r[1] }
  ## reformat date / beautify e.g. Sat Aug 7 1993
  recs.each { |rec| rec[1] = Date.strptime( rec[1], '%Y-%m-%d' ).strftime( '%a %b %-d %Y' ) }

  Mirror::CsvMatchWriter.write( path, recs, headers: headers )
end

puts "bye"