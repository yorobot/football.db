# encoding: utf-8


def build_page_toc( opts={} )
  ### generate table of contents (toc)

  if opts[:inline].present?
    file_path  = '_pages/book.md'
    file_flags = 'a+'   ## Append; open or create file for update, writing at end-of-file.
  else
    file_path = '_pages/index.md'
    file_flags = 'w+'   ## Truncate to zero length or create file for update. 
    opts = opts.merge( frontmatter: {
                         layout:    'book',
                         title:     'Contents',
                         permalink: '/index.html' } )
  end

#### fix: move frontmatter option out of render_xxx
## and add to build_page !!!

  File.open( file_path, file_flags ) do |file|
    file.write render_cover( opts )
    file.write render_about( opts.merge( frontmatter: nil ) ) ## hack: remove frontmatter opts
    file.write render_toc( opts.merge( frontmatter: nil ) )
  end
end


def build_page_for_event( event, opts={} )

  header = <<EOS

---------------------------------------

EOS

  if opts[:inline].present?
    file_path  = '_pages/book.md'
    file_flags = 'a+'   ## Append; open or create file for update, writing at end-of-file.
    opts = opts.merge( header: header )
  else
    key = event.key.gsub( '/', '_' )
    file_path = "_pages/events/#{key}.md"
    file_flags = 'w+'   ## Truncate to zero length or create file for update. 
    opts = opts.merge( frontmatter: {
                          layout:    'book',
                          title:     "#{event.title}",
                          permalink: "/#{key}.html"     } )
  end

  File.open( file_path, file_flags ) do |file|
    file.write render_event( event, opts )
  end
  
end # methodd build_pages_for_events


def build_page_for_country( country, opts={} )

  header = <<EOS

---------------------------------------

EOS

  if opts[:inline].present?
    file_path  = '_pages/book.md'
    file_flags = 'a+'   ## Append; open or create file for update, writing at end-of-file.
    opts = opts.merge( header: header )
  else
    path = country_to_md_path( country )
    puts "    path=#{path}"
    file_path = "_pages/teams/#{path}"
    file_flags = 'w+'   ## Truncate to zero length or create file for update. 
    opts = opts.merge( frontmatter: {
                          layout:    'book',
                          title:     "#{country.title} (#{country.code})",
                          permalink: "/#{country.key}.html"     } )
  end

  File.open( file_path, file_flags ) do |file|
    file.write render_country( country, opts )
  end
end

def build_page_grounds( opts={} )
  if opts[:inline].present?
    file_path  = '_pages/book.md'
    file_flags = 'a+'   ## Append; open or create file for update, writing at end-of-file.
  else
    file_path = '_pages/stadiums.md'
    file_flags = 'w+'   ## Truncate to zero length or create file for update. 
    opts = opts.merge( frontmatter: {
                         layout:    'book',
                         title:     'Stadiums',
                         permalink: '/stadiums.html' } )
  end

  File.open( file_path, file_flags ) do |file|
    file.write render_grounds( opts )
  end
end


def build_page_events( opts={} )
  ### generate events index

  if opts[:inline].present?
    file_path  = '_pages/book.md'
    file_flags = 'a+'   ## Append; open or create file for update, writing at end-of-file.
  else
    file_path = '_pages/events.md'
    file_flags = 'w+'   ## Truncate to zero length or create file for update. 
    opts = opts.merge( frontmatter: {
                         layout:    'book',
                         title:     'Events',
                         permalink: '/events.html' } )
  end

  File.open( file_path, file_flags ) do |file|
    file.write render_events( opts )
  end
end


def build_page_national_teams_idx( opts={} )
  ### generate national teams a-z index

  if opts[:inline].present?
    file_path  = '_pages/book.md'
    file_flags = 'a+'   ## Append; open or create file for update, writing at end-of-file.
  else
    file_path = '_pages/national-teams.md'
    file_flags = 'w+'   ## Truncate to zero length or create file for update. 
    opts = opts.merge( frontmatter: {
                         layout:    'book',
                         title:     'National Teams A-Z Index',
                         permalink: '/national-teams.html' } )
  end

  File.open( file_path, file_flags ) do |file|
    file.write render_national_teams_idx( opts )
  end
end

def build_page_clubs_idx( opts={} )
  ### generate teams a-z index

  if opts[:inline].present?
    file_path  = '_pages/book.md'
    file_flags = 'a+'   ## Append; open or create file for update, writing at end-of-file.
  else
    file_path = '_pages/clubs.md'
    file_flags = 'w+'   ## Truncate to zero length or create file for update. 
    opts = opts.merge( frontmatter: {
                         layout:    'book',
                         title:     'Clubs A-Z Index',
                         permalink: '/clubs.html' } )
  end

  File.open( file_path, file_flags ) do |file|
    file.write render_clubs_idx( opts )
  end
end


def build_page_back( opts={} )
  if opts[:inline].present?
    file_path  = '_pages/book.md'
    file_flags = 'a+'   ## Append; open or create file for update, writing at end-of-file.
  else
    file_path = '_pages/back.md'
    file_flags = 'w+'   ## Truncate to zero length or create file for update. 
    opts = opts.merge( frontmatter: {
                         layout:    'book',
                         title:     'Back',
                         permalink: '/back.html' } )
  end

  File.open( file_path, file_flags ) do |file|
    file.write render_back( opts )
  end
end

