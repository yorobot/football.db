####
#  mirror datasets - export to csv

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
              ## get values from record (use empty string if not found)
              values = headers.map {|header| rec[header] || '' }
              f.write values.join(',')
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

  next if event.league.key.start_with?( 'at.rel' )
  ## next if event.league.key.start_with?( 'at.cup' )


  ## check for stages
  stage_count  = event.stages.count
  match_count  = event.matches.count

  puts "write #{event.league.key} - #{event.season.key}  (#{match_count} matches, #{stage_count} stages)"


  recs = []
  event.matches.each do |match|

     ## try to find / use matchday for "simple" rounds
     ##   otherwise use round name as is
     matchday = if match.round.name =~ /(?:Round|Matchday|Spieltag|Runde|Jornada) ([0-9]+)/ ||
                   match.round.name =~ /([0-9]+)\. (?:Runde|Spieltag)/
                  $1
                else
                  nil
                end

    round = if matchday
              matchday
            else
              ## note: change comma to pipe if present e.g.
              ##  Finale, Hinspiel  =>  Finale | Hinspiel etc.
              ##   note auto-add a space now after comma too!!!
              match.round.name.gsub( ',', ' |' )
            end

    ## todo/fix: add support for cancelled/canceled, awarded (awd.), etc.
    ## todo/fix: add support for ET and PT too!!!

    rec = {'Round'  => round,
           'Date'   => match.date.strftime('%Y-%m-%d'),
           'Team 1' => match.team1.name,
           'FT'     => match.score1 && match.score2 ? "#{match.score1}-#{match.score2}" : '',
           'Team 2' => match.team2.name }

   ## todo/fix: later shorten known stage names
   if stage_count > 0
    rec[ 'Stage' ] = match.stage.name
    ## todo/fix: report error if no stage assigned to match!!!
   end

    recs << rec
  end # each match


  headers = if stage_count > 0
             ['Stage',
              'Round',
              'Date',
              'Team 1',
              'FT',
              'Team 2']
            else
             ['Round',    ## use matchday if only numbers - why? why not?
              'Date',
              'Team 1',
              'FT',
              'Team 2']
            end

  basename = event.league.key
  season = Season.new( event.season.key )
  season_path = season.to_path( :archive )  ## e.g. 2010s/2010-11

  ## path = "./o/#{season_path}/#{basename}.csv"
  path = "../../footballcsv/#{reponame}/#{season_path}/#{basename}.csv"
  puts "  path=>#{path}<"
  ## puts "     #{recs.size} records"

  ## sort by date
  recs = recs.sort { |l,r| l['Date'] <=> r['Date'] }
  ## reformat date / beautify e.g. Sat Aug 7 1993
  recs.each { |rec| rec['Date'] = Date.strptime( rec['Date'], '%Y-%m-%d' ).strftime( '%a %b %-d %Y' ) }

  Mirror::CsvMatchWriter.write( path, recs, headers: headers )
end
end # method mirror


## mirror( dbname: 'en', reponame: 'england' )
## mirror( dbname: 'de', reponame: 'deutschland' )
## mirror( dbname: 'at', reponame: 'austria' )
mirror( dbname: 'es', reponame: 'espana' )


puts "bye"