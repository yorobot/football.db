#### todo: urlify - move to misc helpers!!

def urlify( title )
  title.downcase.gsub( ' ', '-' ).gsub( /[^a-z\-]/, '' )
end


def render_erb_template( tmpl, ctx )
  TextUtils::PageTemplate.new( tmpl ).render( ctx )
end
