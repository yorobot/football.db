
desc 'print stats for football.db tables/records'
task :stats => :env do
  puts ''
  puts 'world.db'
  puts '============'
  WorldDb.tables

  puts ''
  puts 'football.db'
  puts '==========='
  SportDb.tables
end
