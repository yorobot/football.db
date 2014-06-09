
def check_repo_paths( ary )
  puts "checking repo paths..."

  ary.each do |entry|
    name = entry[0]
    path = entry[1]

    if Dir.exists?( path )    ## note: same as File.directory?()
      print '  OK               '
    else
      print '  -- NOT FOUND --  '
    end
    print " %-30s <%s>\n" % [name,path]
  end
end


desc 'check repo paths'
task :check => :env do
  check_repo_paths( ALL_REPO_PATHS )
end
