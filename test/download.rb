# encoding: utf-8


require 'fetcher'


## download "raw" cl wikipedia pages

BASE_URL="https://en.wikipedia.org/w/index.php"


## todo/fix: use CGI.escape for title ourselfs - why? why not?
pages = [
 ## champions league (cl)
 [ '2015%E2%80%9316_UEFA_Champions_League_group_stage', '2015-16-cl-group' ],
 [ '2016%E2%80%9317_UEFA_Champions_League_group_stage', '2016-17-cl-group' ],
 [ '2017%E2%80%9318_UEFA_Champions_League_group_stage', '2017-18-cl-group' ],
 [ '2015%E2%80%9316_UEFA_Champions_League_knockout_phase', '2015-16-cl-knockout' ],
 [ '2016%E2%80%9317_UEFA_Champions_League_knockout_phase', '2016-17-cl-knockout' ],
 [ '2017%E2%80%9318_UEFA_Champions_League_knockout_phase', '2017-18-cl-knockout' ],
 [ '2016_UEFA_Champions_League_Final', '2015-16-cl-final' ],
 [ '2017_UEFA_Champions_League_Final', '2016-17-cl-final' ],
 [ '2018_UEFA_Champions_League_Final', '2017-18-cl-final' ],
 ## world cup (world)
 [ '2018_FIFA_World_Cup', '2018-world' ],
]



worker = Fetcher::Worker.new

pages.each do |page|
  title    = page[0]
  basename = page[1]

  url   = "#{BASE_URL}?title=#{title}&action=raw"

  res = worker.get( url )
  if res.code == '200'
    txt = res.body
    path = "./test/wikipedia/#{basename}.txt"
    File.open( path, 'wb' ) do |out|    ## note: use binary (as is 1:1) format e.g. wb
        out.write txt
    end
  else
    puts " *** HTTP error #{res.code} - #{res.message}"
    exit 1
  end
  sleep( 1 )  ## 1 second sleep (be kind to server)
end

puts 'ok - done - bye'
