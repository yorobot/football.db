# encoding: utf-8



class Page

   ## convenience short cut
   def self.read( path )
     page = new( path )
     page.text
   end

   attr_reader :text

   U_HYPHEN              = "\u2010"  # unambigous hyphen
   U_NON_BREAKING_HYPHEN = "\u2011"  # unambigous non-breaking hyphen
   U_MINUS               = "\u2212"  # unambigous minus sign (html => &minus;)
   U_NDASH               = "\u2013"  # ndash (html => &ndash; ascii => --)
   U_MDASH               = "\u2014"  # mdash (html => &mdash; ascii => ---)


   def initialize( path, mappings: {} )
     @mappings = mappings
     @text = File.open( path, 'r:bom|utf-8' ).read

     ##   normalize newlines
     ##    always use LF \n (Unix):
     ##
     ##   convert CR/LF \r\n (Windows)  => \n
     ##   convert CR    \r   (old? Mac) => \n  -- still in use?
     @text = @text.gsub( /\r\n|\r/, "\n" )

     @text = @text.gsub( /(#{U_HYPHEN}|#{U_NON_BREAKING_HYPHEN}|#{U_MINUS}|#{U_NDASH}|#{U_MDASH})/ ) do |_|

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
   end  ## method initialize



   def football( heading, sort: false )    ## rename to football_boxes or matches - why? why not?
     sec   = Sectioner.find( @text, heading: heading )
     matches = Boxer.read( sec )

     matches = sort_matches( matches )   if sort
     matches = replace_matches( matches, @mappings )
     matches
   end


private
 ################
 ## helpers

 def sort_matches( matches )
   matches = matches.sort do |l,r|
      Date.parse( l['date'] ) <=> Date.parse( r['date'] )
   end
   matches
 end


 def replace_matches( matches, mappings )
   ## note: for now replaces matches in-place (with side effects)
   matches.each do |match|
      match['team1']   = replace( match['team1'],   mappings[:teams]    )
      match['team2']   = replace( match['team2'],   mappings[:teams]    )
      match['stadium'] = replace( match['stadium'], mappings[:stadiums] )
   end
   matches
 end

 def replace( value, mappings )
   mappings.each do |from,to|
     value = value.gsub( from ) do |_|
       puts "  replacing >#{from}< with >#{to}< in >#{value}<"
       to
     end
   end
   value
 end



end # class Page
