# encoding: utf-8

require 'strscan'   ## StringScanner
require 'pp'
require 'date'


## our own scripts

require_relative 'wikipedia/sectioner'
require_relative 'wikipedia/boxer'



## lets go

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
