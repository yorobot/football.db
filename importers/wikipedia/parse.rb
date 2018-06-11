# encoding: utf-8

## fix: use read utf8!!!

require 'strscan'   ## StringScanner
require 'pp'
require 'date'


## struct heading
## struct  infobox
##           many key=value


## regex doc/info/notes:
##  ^   -- Start of String or Line
##  ?=  -- positive lookahead


class Sectioner

## convenience helper
def self.find( str, opts={} )
   self.new.find( str, opts )
end

def find( str, opts={} )
   @debug  = opts.fetch( :debug, false )
   @buf    = StringScanner.new( str )

   @heading = opts.fetch( :heading, "Untitled" )

   ## keep same level for breaks
   ##  e.g.
   ##   ==Quarter-finals==
   ##   ===Summary===
   ##   ===Matches===
   ##   ==Semi-finals==
   ##
   ##   will include summary and matches!!!


   ## note: scan_until returns nil if no match found
   found = @buf.scan_until( /(?=\={2,}#{@heading}\={2,})/ )   ## note: use ?= lookahead

   if found.nil? || @buf.eos?
      puts "*** error: section with heading >#{@heading}< not found/missing"
      return nil
   end

   heading = @buf.scan( /\={2,}#{@heading}\={2,}/ )
   hopen   = heading[ /\={2,}/ ]
   hlevel = hopen.length   # headding level e.g. 3 or 2 etc.
   pp hlevel

   ## note: if level 3, for example, INCLUDE higher levels 4,5,6 etc.
   ##    break only on 1,2,3
   sec = @buf.scan_until( /(?=(^\={1,#{hlevel}})[^=])/ )   ## unitl next heading or end-of-string

   if sec.nil?
     puts "** note: no more headings; use rest e.g. text until the end-of-string"
     @buf.rest    ## use until end-of-string
   else
     sec
   end
end

end  ## Sectioner




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


def skip_whitespaces
  @buf.skip( /[ \t\n]*/ )    ## skip trailing WHITESPACE
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

end # class Box


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



def format_matches( matches )

  last_date = nil

  matches.each do |match|
     date = Date.parse( match['date'] )
     if date != last_date
       puts "\n[#{date.strftime('%a %b/%d')}]\n"
     end

     print "  #{match['time']}"
     print "  "
     print "%-19s" % match['team1']
     print "  #{match['score']}  "
     print "%-19s" % match['team2']
     print "  @ #{match['stadium']}"
     print "\n"

     last_date = date
  end
end



text = File.open( './wikipedia/2017-18-cl-group.txt', 'r:bom|utf-8' ).read

##   normalize newlines
##    always use LF \n (Unix):
##
##   convert CR/LF \r\n (Windows)  => \n
##   convert CR    \r   (old? Mac) => \n  -- still in use?
text = text.gsub( /\r\n|\r/, "\n" )

U_HYPHEN              = "\u2010"  # unambigous hyphen
U_NON_BREAKING_HYPHEN = "\u2011"  # unambigous non-breaking hyphen
U_MINUS               = "\u2212"  # unambigous minus sign (html => &minus;)
U_NDASH               = "\u2013"  # ndash (html => &ndash; ascii => --)
U_MDASH               = "\u2014"  # mdash (html => &mdash; ascii => ---)

text = text.gsub( /(#{U_HYPHEN}|#{U_NON_BREAKING_HYPHEN}|#{U_MINUS}|#{U_NDASH}|#{U_MDASH})/ ) do |_|

      # puts "found U+#{'%04X' % $1.ord} (#{$1})"

      msg = ''

      if $1 == U_HYPHEN
        msg << "found hyhpen U+2010 (#{$1})"
      elsif $1 == U_NON_BREAKING_HYPHEN
        msg << "found non_breaking_hyhpen U+2011 (#{$1})"
      elsif $1 == U_MINUS
        msg << "found minus U+2212 (#{$1})"
      elsif $1 == U_NDASH
        msg << "found ndash U+2013 (#{$1})"
      elsif $1 == U_MDASH
        msg << "found mdash U+2014 (#{$1})"
      else
        msg << "found unknown unicode dash U+#{'%04X' % $1.ord} (#{$1})"
      end

      msg << "; converting to plain ascii hyphen_minus (-)"

      puts "*** warning: #{msg}"

      '-'
    end

sec_a = Sectioner.find( text, heading: "Group A" )
sec_b = Sectioner.find( text, heading: "Group B" )
sec_c = Sectioner.find( text, heading: "Group C" )

boxes_a = Boxer.read( sec_a )
boxes_b = Boxer.read( sec_b )
boxes_c = Boxer.read( sec_c )

## pp boxes_a
## pp boxes_b
pp boxes_c

puts "Group A:"
format_matches( boxes_a )
puts "Group B:"
format_matches( boxes_b )
puts "Group C:"
format_matches( boxes_c )
