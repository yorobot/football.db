# encoding: utf-8

##########################
# page helpers


def render_cover( opts={} )
  
  ### rename to render_page_template( 'cover' )  !!!!
  
  tmpl = File.read_utf8( 'templates/cover.md' )
  render_erb_template( tmpl, binding )
end

def render_about( opts={} )
  tmpl = File.read_utf8( 'templates/about.md' )
  render_erb_template( tmpl, binding )
end


def render_events( opts={} )
  tmpl = File.read_utf8( 'templates/events.md' )
  render_erb_template( tmpl, binding )
end

def render_grounds( opts={} )
  tmpl = File.read_utf8( 'templates/grounds.md' )
  render_erb_template( tmpl, binding )
end


def render_event( event, opts={} )
  tmpl = File.read_utf8( 'templates/event.md' )
  render_erb_template( tmpl, binding )
end


def render_country( country, opts={} )
  tmpl = File.read_utf8( 'templates/country.md' )
  render_erb_template( tmpl, binding )
end

def render_toc( opts={} )
  tmpl = File.read_utf8( 'templates/toc.md' )
  render_erb_template( tmpl, binding )
end


def render_national_teams_idx( opts={} )
  tmpl = File.read_utf8( 'templates/national-teams-idx.md' )
  render_erb_template( tmpl, binding )
end

def render_clubs_idx( opts={} )
  tmpl = File.read_utf8( 'templates/clubs-idx.md' )
  render_erb_template( tmpl, binding )
end


def render_back( opts={} )
  tmpl = File.read_utf8( 'templates/back.md' )
  render_erb_template( tmpl, binding )
end

