# encoding: utf-8



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
