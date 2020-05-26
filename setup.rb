# encoding: utf-8


require 'gitti'
require 'gitti/sync'

include Gitti    ## lets you use Git, GitError, etc.


## note: ../.. => /Sites  assuming started in  /Sites/yorobot/football.db
sync = GitSync.new( '../..' )

repos = GitRepoSet.from_file( './repos.yml' )
sync.sync( repos )
