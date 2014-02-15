# encoding: utf-8

def ground_title( ground )   # ground title plus synonyms if present
  
  #### fix: use generic
  ##  title_with_synonyms_for( o, opts={} )  !!!!!
  ##

  buf = ''
  buf << ground.title
  if ground.synonyms.present?
    buf << ' • '
    buf << ground.synonyms.gsub('|', ' • ')
  end
  buf
end
