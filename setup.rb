# encoding: utf-8


require 'gitti'
require 'gitti/sync'

include Gitti    ## lets you use Git, GitError, etc.


## todo/fix: change to /Sites

sync = GitSync.new( '../..' )   ## '/src' or '/Sites' was /auto

repos = GitRepoSet.from_file( './repos.yml' )
sync.sync( repos )
