###############################
# link helpers


def link_to_event( event, opts={} )
  if opts[:inline].nil?
    href = "#{event.key.gsub('/','_')}.html"   # multi-page version
  else
    href = "##{event.key.gsub('/','_')}"       # all-in-one page version
  end

  if opts[:season].nil?
    title = event.title          # use full title e.g. World Cup 2014
  else
    title = event.season.title   # use only season e.g. 2014
  end

  link_to title, href
end


def link_to_country( country, opts={} )
  if opts[:inline].nil?
    href = "#{country.key}.html"   # multi-page version
  else
    href = "##{country.key}"       # all-in-one page version
  end

  link_to "#{country.title} (#{country.code})", href
end


def link_to_team( team, opts={} )
  if opts[:inline].nil?
    href = "#{team.country.key}.html##{team.key}"   # multi-page version
  else
    href = "##{team.key}"       # all-in-one page version
  end

  title = ''
  title << team.title
  title << " (#{team.code})"  if team.code.present?

  link_to title, href
end

