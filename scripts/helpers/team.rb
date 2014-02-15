# encoding: utf-8

def team_title( team )   # team title plus synonyms if present

  #### fix: use generic
  ##  title_with_synonyms_for( o, opts={} )  !!!!!
  ##


  buf = ''
  buf << team.title
  if team.synonyms.present?
    buf << ' • '
    buf << team.synonyms.gsub('|', ' • ')
  end
  buf
end
