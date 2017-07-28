# encoding: utf-8


def save_logs( opts={} )
  out_root = opts[:out_root] || './build'

  out_path = "#{out_root}/build.log"    ## todo/check: use football.txt - why? why not?
  puts "out_path=>>#{out_path}<<"

  ## make sure parent folders exist
  FileUtils.mkdir_p( File.dirname(out_path) ) unless Dir.exists?( File.dirname( out_path ))

  File.open( out_path, 'w' ) do |out|
    out.puts "# Logs \n"
    out.puts "\n"
    out.puts "---begin---\n"
    out.puts build_logs
    out.puts "---end---\n"
    out.puts "\n\n"
  end
end


def build_logs
  buf = ''
  buf << "#{LogDb::Model::Log.count} logs:\n"    ## show count for warn, error, info etc.
  LogDb::Model::Log.order('created_at').each do |log|
    buf << "[#{log.level}] #{log.msg}\n"
  end
  buf
end
