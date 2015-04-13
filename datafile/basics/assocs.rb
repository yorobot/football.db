######################
# assocs

task :assocs => :importbuiltin do
  ##  football 'national-teams'
  football 'national-teams', setup: 'assocs'

  calc do
    ## dump assocs stats for fifa plus all sub orgs/zones
    fifa = SportDb::Model::Assoc.find_by_key!( 'fifa' )
    dump_assoc( fifa, 1 )
  end
end

task :assocs_stats => :env do
  calc do
    ## dump assocs stats for fifa plus all sub orgs/zones
    fifa = SportDb::Model::Assoc.find_by_key!( 'fifa' )
    dump_assoc( fifa, 1 )
  end
end


def dump_assoc( assoc, level, opts={} )
  return if assoc.national?

  indent = " " * (level*2)
  puts "  #{indent}#{level} -- #{assoc.title} / national assocs #{assoc.national_assocs.count}"
  
  sub_assocs_count = assoc.sub_assocs.count
  if sub_assocs_count > 0
    puts "    #{indent} sub zones #{sub_assocs_count}:"

    assoc.sub_assocs.each do |sub_assoc|
      dump_assoc( sub_assoc, level+1, opts )
    end
  end

=begin
  if level == 1
    puts ""
    puts "       national assocs #{assoc.national_assocs.count}:"
    ## print national assocs here?
  end
=end
end
