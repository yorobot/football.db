# encoding: utf-8


## champions league (cl) from wikipedia


require_relative '../importers/wikipedia'


## struct heading
## struct  infobox
##           many key=value


text = File.open( './test/wikipedia/2017-18-cl-group.txt', 'r:bom|utf-8' ).read

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
