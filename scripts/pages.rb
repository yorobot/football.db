# encoding: utf-8


def build_page_toc( opts={} )
  ### generate table of contents (toc)

  if opts[:inline].present?
    Page.update( 'book' ) do |page|
      page.write render_cover( opts )
      page.write render_about( opts )
      page.write render_toc( opts )
    end
  else
    Page.create( 'index', frontmatter: {
                            layout:    'book',
                            title:     'Contents',
                            permalink: '/index.html' } ) do |page|
      page.write render_cover( opts )
      page.write render_about( opts )
      page.write render_toc( opts )
    end
  end
end


def build_page_for_event( event, opts={} )

  header = <<EOS

---------------------------------------

EOS

  if opts[:inline].present?
    Page.update( 'book', header: header ) do |page|
      page.write render_event( event, opts )
    end
  else
    key = event.key.gsub( '/', '_' )
    Page.create( "events/#{key}", frontmatter: {
                          layout:    'book',
                          title:     "#{event.title}",
                          permalink: "/#{key}.html"     } ) do |page|
      page.write render_event( event, opts )
    end
  end

end # methodd build_pages_for_events


def build_page_for_country( country, opts={} )

  header = <<EOS

---------------------------------------

EOS

  if opts[:inline].present?
    Page.update( 'book', header: header ) do |page|
      page.write render_country( country, opts )
    end
  else
    path = country_to_path( country )
    puts "    path=#{path}"
    Page.create( "teams/#{path}", frontmatter: {
                          layout:    'book',
                          title:     "#{country.title} (#{country.code})",
                          permalink: "/#{country.key}.html"     } ) do |page|
      page.write render_country( country, opts )
    end
  end

end


def build_page_grounds( opts={} )
  if opts[:inline].present?
    Page.update( 'book' ) do |page|
      page.write render_grounds( opts )
    end
  else
    Page.create( 'stadiums', frontmatter: {
                         layout:    'book',
                         title:     'Stadiums',
                         permalink: '/stadiums.html' }) do |page|
      page.write render_grounds( opts )
    end
  end
end


def build_page_events( opts={} )
  ### generate events index

  if opts[:inline].present?
    Page.update( 'book' ) do |page|
      page.write render_events( opts )
    end
  else
    Page.create( 'events', frontmatter: {
                         layout:    'book',
                         title:     'Events',
                         permalink: '/events.html' }) do |page|
      page.write render_events( opts )
    end
  end
end


def build_page_national_teams_idx( opts={} )
  ### generate national teams a-z index

  if opts[:inline].present?
    Page.update( 'book' ) do |page|
      page.write render_national_teams_idx( opts )
    end
  else
    Page.create( 'national-teams', frontmatter: {
                         layout:    'book',
                         title:     'National Teams A-Z Index',
                         permalink: '/national-teams.html' } ) do |page|
      page.write render_national_teams_idx( opts )
    end
  end
end

def build_page_clubs_idx( opts={} )
  ### generate teams a-z index

  if opts[:inline].present?
    Page.update( 'book' ) do |page|
      page.write render_clubs_idx( opts )
    end
  else
    Page.create( 'clubs', frontmatter: {
                         layout:    'book',
                         title:     'Clubs A-Z Index',
                         permalink: '/clubs.html' } ) do |page|
      page.write render_clubs_idx( opts )
    end
  end
end


def build_page_back( opts={} )
  if opts[:inline].present?
    Page.update( 'book' ) do |page|
      page.write render_back( opts )
    end
  else
    Page.create( 'back', frontmatter: {
                         layout:    'book',
                         title:     'Back',
                         permalink: '/back.html' } ) do |page|
      page.write render_back( opts )
    end
  end
end

