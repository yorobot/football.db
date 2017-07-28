# encoding: utf-8


def build_teams_report( fixtures, root, title: 'Clubs' )
  buf = ''

  fixtures = fixtures.sort   ## sort by a-z (why? why not?)

  fixtures.each do |fx|
    path = "#{root}/#{fx}"
    
    h = SportDb::TeamIndexer.from_file( path ).read
    
    buf << build_teams( fx, h )
  end
  
  buf2 = ''
  buf2 << "\n\n"
  buf2 << "### #{title}\n"
  buf2 << "\n"
  buf2 << buf
  buf2 << "\n"
  buf2 << "\n"
  
  buf2
end


def build_teams( fx, h )

  puts "   #{fx} (#{h.size})..."

  buf = ""

  buf << "\n"
  buf << "**[#{fx}](#{fx})** _(#{h.size})_ -- \n"

  h.each_with_index do |(k,v),i|
    title    = v[:title]
    synonyms = v[:synonyms]
    
    values = v[:values] || []
    ## check for country code (cc) (must be all lowercase)
    cc = values.find { |item| item =~ /^[a-z]{2,3}$/ }
    
    buf << title
    buf << " _(#{cc})_"   if cc     ## print country code if present/found
    buf << ' •'           if i+1 < h.size   ## don't print for last item
    buf << "\n"
  end

  buf << "\n"
  buf << "\n"
end

