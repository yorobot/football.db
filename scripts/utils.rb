#### todo: urlify - move to misc helpers!!

def urlify( title )
  title.downcase.gsub( ' ', '-' ).gsub( /[^a-z\-]/, '' )
end


def render_frontmatter( h )
  buf = ''
  buf += "---\n"

  h.each do |key,value|
    buf += "#{key}: #{value}\n"
  end

  buf += "---\n\n"
  buf
end


def render_erb_template( tmpl, ctx )

# note: erb offers the following trim modes:
#  1) <> omit newline for lines starting with <% and ending in %>
#  2)  >  omit newline for lines ending in %>
#  3)  omit blank lines ending in -%>
  ## run filters
  tmpl = remove_html_comments( tmpl )
  tmpl = remove_blanks( tmpl )

  tmpl = django_to_erb( tmpl )  ## allow django/jinja style templates

  tmpl = remove_leading_spaces( tmpl )
  tmpl = concat_lines( tmpl )

  text = ERB.new( tmpl, nil, '<>' ).result( ctx )

  ### text = cleanup_newlines( text )
  text
end