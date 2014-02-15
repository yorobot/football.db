# encoding: utf-8


#####
# todo/fix: use constant to set  ./_pages   - output (root) folder for generated pages
# todo/fix: use constant to set layout  e.g. book

puts '[book] Welcome'
puts "[book]   Dir.pwd: #{Dir.pwd}"



# -- custom code

require_relative 'helpers/link'
require_relative 'helpers/markdown'
require_relative 'helpers/navbar'
require_relative 'helpers/part'
require_relative 'helpers/misc'
require_relative 'helpers/city'
require_relative 'helpers/ground'
require_relative 'helpers/team'
require_relative 'helpers/page'


require_relative 'filters'
require_relative 'utils'
require_relative 'pages'



def build_book( opts={} )


  if opts[:inline].present?
    ## generate inline (all-in-one-page) version

    File.open( '_pages/book.md', 'w+' ) do |file|
      file.write  <<EOS
---
layout: book
title: Contents
permalink: /book.html
---

EOS
    end
  end


  build_page_toc( opts )
  
  
  # note: use same order as table of contents
  event_count = 0
  League.all.each do |league|
    next if league.events.count == 0

    league.events.each do |event|
       puts "  build event page [#{event_count+1}] #{event.key} #{event.title}..."
       build_page_for_event( event, opts )
       event_count += 1
    end
  end

  ## build_page_events( opts )


  # note: use same order as table of contents
  country_count = 0
  Continent.all.each do |continent|
    continent.countries.order(:title).each do |country|
      next if country.teams.count == 0   # skip country w/o teams

      puts "  build country page [#{country_count+1}] #{country.key} #{country.title}..."
      build_page_for_country( country, opts )
      country_count += 1
    end
  end


  build_page_grounds( opts )

  build_page_national_teams_idx( opts )
  build_page_clubs_idx( opts )

  build_page_back( opts )


end # method build_book

