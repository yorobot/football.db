# encoding: utf-8

require 'strscan'   ## StringScanner
require 'pp'
require 'date'


## our own scripts

require_relative 'wikipedia/sectioner'
require_relative 'wikipedia/boxer'
require_relative 'wikipedia/page'



## lets go

def format_matches( matches )

  last_date = nil

  buf = ""

  matches.each do |match|
     date = Date.parse( match['date'] )
     if date != last_date
       buf << "\n[#{date.strftime('%a %b/%d')}]\n"
     end

     buf << "  #{match['time']}"
     buf << "  "
     buf << "%-19s" % match['team1']
     buf << "  #{match['score']}  "
     buf << "%-19s" % match['team2']
     buf << "  @ #{match['stadium']}"
     buf << "\n"

     if match['goals1'].length > 0 || match['goals2'].length > 0
       buf << "           ["
       if match['goals1'].length > 0
         buf << "#{match['goals1']}"
       else
         buf << "-"
       end
       if match['goals2'].length > 0
         buf << "; "
         buf << "#{match['goals2']}"
       end
       buf << "]\n"
     end

     last_date = date
  end
  buf
end
