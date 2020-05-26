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
      [^\}]+?     # everything but curly bracket (note: use non-greedy op ?)
    \}\}
  }

GOAL_PATTERN = %q{
    \{\{
      goal\|
      (?<params>[^\}]+?)     # everything but curly bracket (note: use non-greedy op ?)
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


CREF2_PATTERN = %q{
    \{\{
       Cref2\|
       [^\}]+?       # everything but curly bracket (note: use non-greedy op ?)
     \}\}
  }

REFN_PATTERN = %q{
    \{\{
       refn\|
       [^\}]+?       # everything but curly bracket (note: use non-greedy op ?)
     \}\}
  }

CITE_PATTERN = %q{
    \{\{
       cite
       [^\}]+?       # everything but curly bracket (note: use non-greedy op ?)
     \}\}
  }

## e.g. as in
##  [Wed Apr/19]
##    20.50{{refn|group=note|name=MONvDOR delayed|The Monaco v Borussia Dortmund match, originally scheduled for 20.45 CEST, was delayed to 20.50 CEST due to late team arrival caused by heavy traffic.<ref>{{cite web |url=http.//www.express.co.uk/sport/football/793929/Monaco-Borussia-Dortmund-bus-delay |title=Monaco v Borussia Dortmund delayed. German side's bus stopped by police again |website=express.co.uk |publisher=[[Daily Express]] |date=19 April 2017 |access-date=19 April 2017}}</ref>}}  ##         Monaco   3-1  Borussia Dortmund    @ Stade Louis II, Monaco


def has_refn?( str )
   /#{REFN_PATTERN}/x =~ str ? true : false
end

def has_cref2?( str )
   /#{CREF2_PATTERN}/x =~ str ? true : false
end


def strip_refn( str )
  str = str.gsub( /#{REFN_PATTERN}/x ) do |_|
    puts "rm refn in >#{str}<"
    ''
  end
  str
end

def strip_cref2( str )
  str = str.gsub( /#{CREF2_PATTERN}/x ) do |_|
    puts "rm cref2 in >#{str}<"
    ''
  end
  str
end


def strip_cite( str )
  str = str.gsub( /#{CITE_PATTERN}/x ) do |_|
    puts "rm cite in >#{str}<"
    ''
  end
  str
end




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

def convert_goal_params( params )
  values = params.split('|')
  buf = ""
  values.each_slice(2).with_index do |a,i|
    pp i
    pp a
    minutes = a[0]
    extra   = a[1]

    if i > 0
       buf << ", "
    end

    buf << "#{minutes}'"
    if extra && extra.length > 0
      buf << " (#{extra})"
    end
  end
  buf
end

def convert_goals( str )
  str = str.gsub( /^\*/, '' )     ## remove leading *
  str = str.gsub( /\n/, ' ' )     ## replace newline with space (new format)
  str = str.gsub( /<br[^>]*?>/, ' ' )   ## replace br with space (old format) e.g. allow <br> or <br /> etc.

  str = str.gsub( /#{GOAL_PATTERN}/x ) do |_|
    puts "goal"
    m = Regexp.last_match
    pp m
    convert_goal_params( m[:params] )
  end
  str = str.gsub( /[ ]{2,}/, ' ' )   ## remove double/triple spaces with single space
  str.strip
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


  ## track (foot)notes/references with a flag for now
  notes = false

  team1 = box['team1']
  team1 = rm_flagicons( team1 )
  team1 = unfold_links( team1 )

  team2 = box['team2']
  team2 = rm_flagicons( team2 )
  team2 = unfold_links( team2 )

  stadium = box['stadium']
  if has_cref2?( stadium ) || has_refn?( stadium )
    notes = true
  end
  stadium = strip_cref2( stadium )
  stadium = strip_cite( stadium )    ## note: strip cite inside refn first
  stadium = strip_refn( stadium )
  stadium = unfold_links( stadium )

  ## note: score can have a link too (if link to special match e.g.)
  ##    https://en.wikipedia.org/wiki/Barcelona_6%E2%80%931_Paris_Saint-Germain
  ##      2016–17 Champions League, Round of 16, second leg
  score = box['score']
  score = unfold_links( score )

  goals1 = unfold_links( box['goals1'] )
  goals1 = convert_goals( goals1 )

  goals2 = unfold_links( box['goals2'] )
  goals2 = convert_goals( goals2 )


  time   = box['time']
  if has_refn?( time )
    notes = true
  end
  time = strip_cite( time )    ## note: strip cite inside refn first (see Monaco vs Borussia Dortmund, cl-finals 2016-17 as an example)
  time = strip_refn( time )
  time = time.gsub( ':', '.' )     ## change 20:45 to 20.45


  box_new = {
    'team1'   => team1,
    'team2'   => team2,
    'stadium' => stadium,
    'score'   => score,
    'time'    => time,
    'date'    => convert_start_date( box['date'] ),
    'goals1'  => goals1,
    'goals2'  => goals2,
    'notes'   => notes,
  }
  pp box_new

  ## puts "  team1: >#{team1}<"
  ## puts "  team2: >#{team2}<"
  ## puts "  stadium: >#{stadium}<"
  ## puts "  score: >#{score}<"

  box_new
end

end # class Box
