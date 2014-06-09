

desc 'print logs (stored in db)'
task :logs => :env do
  
  puts "db logs (#{LogDb::Models::Log.count})"
  LogDb::Models::Log.order(:id).each do |log|
     puts "  [#{log.level}] #{log.ts}  - #{log.msg}"
  end

end
