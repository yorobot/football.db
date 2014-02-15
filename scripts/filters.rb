#######################
# filters
#
#  todo: move to textutils for reuse !!!


def django_to_erb( text )
  ## convert django style markers to erb style marker e.g
  #  {% %} becomes <% %>  -- supports multi-line
  #  {{ }} becomes <%= %>  - does NOT support multi-line

  ## comments (support multi-line)
  text = text.gsub( /\{#(.+?)#\}/m ) do |_|
   "<%# #{1} %>"
  end

  text = text.gsub( /\{%(.+?)%\}/m ) do |_|
    ## note: also replace newlines w/  %>\n<%  to split
    #   multi-line stmts into single-line stmts
    # lets us use
    # {%
    #  %} will become
    # <%  %>
    # <%  %>
    "<% #{$1} %>".gsub( "\n", " %>\n<% " )
  end

  # note: for now {{ }} will NOT support multi-line
  text = text.gsub( /\{\{(.+?)\}\}/ ) do |_|
    "<%= #{$1} %>"
  end

  text
end

def remove_html_comments( text )
  text.gsub( /<!--.+?-->/, '' )
end

def remove_leading_spaces( text )
  # remove leading spaces if less than four !!!
  text.gsub( /^[ \t]+(?![ \t])/, '' )    # use negative regex lookahead e.g. (?!)
end

def remove_blanks( text )
  # remove lines only with  ..
  text.gsub( /^[ \t]*\.{2}[ \t]*\n/, '' )
end

def cleanup_newlines( text )
  # remove all blank lines that go over three
  text.gsub( /\n{4,}/, "\n\n\n" )
end


def concat_lines( text )
  #  lines ending with  ++  will get newlines get removed
  # e.g.
  # >|   hello1 ++
  # >1   hello2
  #  becomes
  # >|   hello1 hello2
  
  #
  # note: do NOT use \s - will include \n (newline) ??
  
  text.gsub( /[ \t]+\+{2}[ \t]*\n[ \t]*/, ' ' )  # note: replace with single space
end