# encoding: utf-8


def build_page_toc( opts={} )
  ### generate table of contents (toc)

  if opts[:inline].present?
    page_name  = 'book'
    page_mode = 'a+'   ## Append; open or create file for update, writing at end-of-file.
    page_opts = {}
  else
    page_name = 'index'
    page_mode = 'w+'   ## Truncate to zero length or create file for update. 
    page_opts = { frontmatter: {
                         layout:    'book',
                         title:     'Contents',
                         permalink: '/index.html' }}
  end


  open_page( page_name, page_mode, page_opts ) do |page|
    page.write render_cover( opts )
    page.write render_about( opts )
    page.write render_toc( opts )
  end
end


def build_page_for_event( event, opts={} )

  header = <<EOS

---------------------------------------

EOS

  if opts[:inline].present?
    page_name  = 'book'
    page_mode  = 'a+'   ## Append; open or create file for update, writing at end-of-file.
    page_opts  = { header: header }
  else
    key = event.key.gsub( '/', '_' )
    page_name = "events/#{key}"
    page_mode = 'w+'   ## Truncate to zero length or create file for update. 
    page_opts = { frontmatter: {
                          layout:    'book',
                          title:     "#{event.title}",
                          permalink: "/#{key}.html"     }}
  end

  open_page( page_name, page_mode, page_opts ) do |page|
    page.write render_event( event, opts )
  end

end # methodd build_pages_for_events


def build_page_for_country( country, opts={} )

  header = <<EOS

---------------------------------------

EOS

  if opts[:inline].present?
    page_name  = 'book'
    page_mode  = 'a+'   ## Append; open or create file for update, writing at end-of-file.
    page_opts  = { header: header }
  else
    path = country_to_path( country )
    puts "    path=#{path}"
    page_name = "teams/#{path}"
    page_mode = 'w+'   ## Truncate to zero length or create file for update. 
    page_opts = { frontmatter: {
                          layout:    'book',
                          title:     "#{country.title} (#{country.code})",
                          permalink: "/#{country.key}.html"     }}
  end

  open_page( page_name, page_mode, page_opts ) do |page|
    page.write render_country( country, opts )
  end
end


def build_page_grounds( opts={} )
  if opts[:inline].present?
    page_name  = 'book'
    page_mode  = 'a+'   ## Append; open or create file for update, writing at end-of-file.
    page_opts  = {}
  else
    page_name = 'stadiums'
    page_mode = 'w+'   ## Truncate to zero length or create file for update. 
    page_opts = { frontmatter: {
                         layout:    'book',
                         title:     'Stadiums',
                         permalink: '/stadiums.html' }}
  end

  open_page( page_name, page_mode, page_opts ) do |page|
    page.write render_grounds( opts )
  end
end


def build_page_events( opts={} )
  ### generate events index

  if opts[:inline].present?
    page_name  = 'book'
    page_mode  = 'a+'   ## Append; open or create file for update, writing at end-of-file.
    page_opts  = {}
  else
    page_name  = 'events'
    page_mode  = 'w+'   ## Truncate to zero length or create file for update. 
    page_opts  = { frontmatter: {
                         layout:    'book',
                         title:     'Events',
                         permalink: '/events.html' }}
  end

  open_page( page_name, page_mode, page_opts ) do |page|
    page.write render_events( opts )
  end
end


def build_page_national_teams_idx( opts={} )
  ### generate national teams a-z index

  if opts[:inline].present?
    page_name  = 'book'
    page_mode  = 'a+'   ## Append; open or create file for update, writing at end-of-file.
    page_opts  = {}
  else
    page_name = 'national-teams'
    page_mode = 'w+'   ## Truncate to zero length or create file for update. 
    page_opts = { frontmatter: {
                         layout:    'book',
                         title:     'National Teams A-Z Index',
                         permalink: '/national-teams.html' }}
  end

  open_page( page_name, page_mode, page_opts ) do |page|
    page.write render_national_teams_idx( opts )
  end
end

def build_page_clubs_idx( opts={} )
  ### generate teams a-z index

  if opts[:inline].present?
    page_name = 'book'
    page_mode = 'a+'   ## Append; open or create file for update, writing at end-of-file.
    page_opts  = {}
  else
    page_name = 'clubs'
    page_mode = 'w+'   ## Truncate to zero length or create file for update. 
    page_opts = { frontmatter: {
                         layout:    'book',
                         title:     'Clubs A-Z Index',
                         permalink: '/clubs.html' }}
  end

  open_page( page_name, page_mode, page_opts ) do |page|
    page.write render_clubs_idx( opts )
  end
end


def build_page_back( opts={} )
  if opts[:inline].present?
    page_name  = 'book'
    page_mode  = 'a+'   ## Append; open or create file for update, writing at end-of-file.
    page_opts  = {}
  else
    page_name  = 'back'
    page_mode  = 'w+'   ## Truncate to zero length or create file for update. 
    page_opts  = { frontmatter: {
                         layout:    'book',
                         title:     'Back',
                         permalink: '/back.html' }}
  end

  open_page( page_name, page_mode, page_opts ) do |page|
    page.write render_back( opts )
  end
end

