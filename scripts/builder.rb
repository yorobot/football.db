# encoding: utf-8

####
## task builder for rake
##  - reads in all datafiles and builds/generates rake tasks
##


require 'pp'


### 3rd party libs/gems
require 'textutils'
require 'datafile'


def collect_datafiles
  puts "[debug] enter collect datafiles"

  ary = []

  files = Dir["./datafile/**/*.rb"]
  files.each_with_index do |file,idx|
     puts " [#{idx+1}/#{files.count}] try reading '#{file}'..."
     
     builder = Datafile::BuilderEx.load_file( file )

     datafiles = builder.datafiles
     ary += datafiles

     datafiles.each do |datafile|
       puts "=== datafile '#{datafile.name}' => #{datafile.deps.inspect}:"
       puts "  #{datafile.datasets.size} datasets, #{datafile.scripts.size} scripts"
       # datafile.dump
     end
  end
  ary
end # method build_rake_tasks


if __FILE__ == $0
  datafiles = collect_datafiles()
end
