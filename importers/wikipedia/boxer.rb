# encoding: utf-8


## regex doc/info/notes:
##  ^   -- Start of String or Line
##  ?=  -- positive lookahead


class Boxer

## convenience helper
def self.read( str, opts={} )
   self.new.read( str, opts )
end

def read( str, opts={} )
   @debug  = opts.fetch( :debug, false )
   @buf    = StringScanner.new( str )

   boxes = []

   loop do
     ## note: scan_until returns nil if no match found
     found = @buf.scan_until( /(?=\{\{Football box)/ )
     if found.nil? || @buf.eos? || @buf.peek(3) != '{{F'
        puts "rest: >#{@buf.rest}<"
        break
     end
     h = parse_box
     boxes << h
   end

   ## pp boxes
   boxes

   boxes = boxes.map {|box| convert_box( box ) }
end


def parse_cols
   h = {}

   loop do
     @buf.skip( /\|/ )
     key   = @buf.scan_until( /(?=\=)/ )   ## check is = special?
     @buf.skip( /\=/ )
     value = @buf.scan_until( /(?=(^\|)|(^\}\}))/ )

     puts
     puts "  key:   >#{key}<"
     puts "  value: >#{value}<"

     ## note: remove/strip leading and trailing whitespaces
     h[ key.strip ] = value.strip

     if @buf.peek(2) == '}}'
       @buf.skip( /\}\}/ )
       break
     end
  end

  pp h
  h
end



def parse_box
   puts "football box:"
   @buf.skip( /\{\{Football box/ )
   @buf.scan_until( /(?=^\|)/ )
   h = parse_cols
   h
end


#################################
## conversion helpers

WIKI_LINK_PATTERN = %q{
    \[\[
      (?<link>[^|\]]+)     # everything but pipe (|) or bracket (])
      (?:
        \|
        (?<title>[^\]]+)
      )?                   # optional wiki link title
    \]\]
  }

FLAGICON_PATTERN = %q{
    \{\{
      flagicon
      [^\}]+     # everything but curly bracket
    \}\}
  }



START_DATE_PATTERN = %q{
    \{\{
       Start \s date
       \|(?<year>\d{4})
       \|(?<month>\d{1,2})
       \|(?<day>\d{1,2})
      (?:
        \|
        df=y
      )?                   # optional df??
    \}\}
  }


def convert_start_date( str )
  if str =~ /#{START_DATE_PATTERN}/x
    puts "convert start date"
    m = Regexp.last_match
    pp m
    yyyy = m[:year]
    mm   = m[:month]
    dd   = m[:day]
    str = "%4d-%02d-%02d" % [yyyy,mm,dd]
  else
    print "unknown start date pattern - no match for: >#{str}<"
    exit 1;
  end
  str
end

def rm_flagicons( str )
  str = str.gsub( /#{FLAGICON_PATTERN}/x ) do |_|
    puts "rm flagicon"
    m = Regexp.last_match
    pp m
    ''
  end
  str.strip
end

def unfold_links( str )
  str = str.gsub( /#{WIKI_LINK_PATTERN}/x ) do |_|
    puts "unfold link"
    m = Regexp.last_match
    pp m
    if m[:title]
      puts "unfold link use title >#{m[:title]}<"
      m[:title]
    else
      puts "unfold link use link >#{m[:link]}<"
      m[:link]
    end
  end
  str.strip
end


def convert_box( box )
  puts "** calling convert_box:"
  pp box

  team1 = box['team1']
  team1 = rm_flagicons( team1 )
  team1 = unfold_links( team1 )

  team2 = box['team2']
  team2 = rm_flagicons( team2 )
  team2 = unfold_links( team2 )

  stadium = box['stadium']
  stadium = unfold_links( stadium )

  score = box['score']

  box_new = {
    'team1'   => team1,
    'team2'   => team2,
    'stadium' => stadium,
    'score'   => score,
    'time'    => box['time'].gsub( ":", "."),   ## change 20:45 to 20.45
    'date'    => convert_start_date( box['date'] ),
  }
  pp box_new

  ## puts "  team1: >#{team1}<"
  ## puts "  team2: >#{team2}<"
  ## puts "  stadium: >#{stadium}<"
  ## puts "  score: >#{score}<"

  box_new
end

end # class Box
