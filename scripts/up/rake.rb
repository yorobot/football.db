# encoding: utf-8


####################################################
#  move to main Rakefile - why? why not??
#   or to scripts/utils.rb ????

def debug?
  debug_value = ENV['DEBUG']
  if debug_value &&  ['true', 't', 'yes', 'y'].include?( debug_value.downcase )
    true
  else
    false
  end 
end


def load_tasks
  Dir.glob('./tasks/**/*.rake').each do |r|
    puts "  importing task >#{r}<..."
    import r      ## why use import and not load? load works with .rake extension?
    # see blog.smartlogicsolutions.com/2009/05/26/including-external-rake-files-in-your-projects-rakefile-keep-your-rake-tasks-organized/
  end
end

