

desc 'print versions of gems'
task :about => :env do
  puts ''
  puts 'gem versions'
  puts '============'
  puts "textutils      #{TextUtils::VERSION}     (#{TextUtils.root})"
  puts "worlddb        #{WorldDb::VERSION}     (#{WorldDb.root})"
  puts "sportdb        #{SportDb::VERSION}     (#{SportDb.root})"

  ## todo - add LogUtils  LogDb ??  - check for .root too
  ## add props and tagutils and activerecord_utils too

  ## fix: add PRE too ?? how??
  puts "activerecord  #{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}.#{ActiveRecord::VERSION::TINY}"
end

