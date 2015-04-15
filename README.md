Note: The recommended and easiest way to build yourself
your own database copies (e.g. football.db, worlcup.db, etc.)
is using Datafiles.
See the [`openfootball/datafile`](https://github.com/openfootball/datafile) repo for details.

# Build

Build scripts for football.db, worldcup.db, bundesliga.db, etc.

## Usage

Use `rake -T`  to list all available tasks. Example:

~~~
$ rake -T
~~~

Will print something like:

~~~
rake about          # print versions of gems
rake alltime_stats  # print alltime stats (for checksum mostly)
rake build          # build football.db from scratch (default)
rake check          # check repo paths
rake dump           # print all events w/ groups and matches
rake logs           # print logs (stored in db)
rake matches_stats  # print matches stats (for checksum mostly)
rake standings      # print standings for football.db (test/debug)
rake stats          # print stats for football.db tables/records
rake update         # update football.db
~~~


To get started use the following folder structure and
clone some datasets with git. Example:

~~~
openmundi/               #  -> create folder (e.g. mkdir openmundi)
  world.db               #  -> git clone (see github.com/openmundi)
openfootball/            #  -> create folder
  build                  #  -> git clone
  national-teams         #     ..
  world-cup              #     ..
~~~

Start your build (e.g. `rake build`) inside the `openfootball/build` folder.

Note: You can see (and change) all folder references in the [`settings.rb`](https://github.com/openfootball/build/blob/master/settings.rb) script.


## More Examples

Build the database for the World Cup in Brazil 2014 (from scratch):

~~~
rake build DATA=worldcup2014
~~~

Build the database for all the World Cups:

~~~
rake build DATA=worldcup
~~~

Build the database for the European Champions League 2014/15:

~~~
rake build DATA=cl201415
~~~

Update the database for the European Champions League 2014/15 (after updating your data sets from git):

~~~
rake update DATA=cl201415
~~~

And so on and so forth.



## License

The build scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the
[Open Sports & Friends Forum/Mailing List](http://groups.google.com/group/opensport).
Thanks!

