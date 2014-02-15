###########################
# markdown helpers


def link_to( title, link )
  "[#{title}](#{link})"
end


def columns_begin( opts={} )
  # note: will add  columns2 or columns3 etc. depending on columns option passed in

  columns = opts[:columns] || 300

  buf = ''
  buf << "\n"
  buf << "<div class='columns#{columns}' markdown='1'>\n"
  buf << "\n"
  buf
end

def columns_end()
  buf = ''
  buf << "\n"
  buf << "</div>\n"
  buf << "\n"
  buf
end


### todo: check if we can use columns simply w/ yield for body ??