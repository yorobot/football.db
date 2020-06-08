# football.db Scripts

## Intro

Build scripts for football.db, worldcup.db, bundesliga.db, etc.


## Setup Skripts

Use

```
$ ruby ./setup.rb
```

to setup (sync e.g. clone/pull) all repos to the `/src` folder.

TODO: Change to `/Sites folder` - why? why not? or use `../..`



## Usage

Use `rake -T`  to list all available tasks. Example:

```
$ rake -T
```

Will print something like:


```
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
```


To get started use the following folder structure and
clone some datasets with git. Example:

```
yorobot/                 #  -> create folder (e.g. mkdir yorobot)
  football.db            #  -> git clone
openmundi/               #  -> create folder
  world.db               #  -> git clone (see github.com/openmundi)
openfootball/            #  -> create folder
  national-teams         #  -> git clone (see github.com/openfootball)
  world-cup              #     ..
```


Start your build (e.g. `rake build`) inside the `yorobot/football.db` folder.


Note: You can see (and change) all folder references in the [`settings.rb`](settings.rb) script.


## More Examples

Build the database for the World Cup in Brazil 2014 (from scratch):

```
rake build DATA=worldcup2014
```

Build the database for all the World Cups:

```
rake build DATA=worldcup
```

Build the database for the European Champions League 2014/15:

```
rake build DATA=cl201415
```

Update the database for the European Champions League 2014/15 (after updating your data sets from git):

```
rake update DATA=cl201415
```

And so on and so forth.


## Updates


### Update Standings (Tables)

Use

```
$ rake pull         # to git pull (fetch n merge) all changes (from repos)
```

Note:
Stats are global for database, thus, for now rebuild database for every setup/repo
e.g.:

```
$ rake build recalc DATA=at    # to build all standings tables (reading in all datasets etc.)
$ rake build recalc DATA=de
$ rake build recalc DATA=en
$ rake build recalc DATA=es
$ rake build recalc DATA=it
## $ rake build recalc DATA=ru      ## fix needed for missing dates e.g. []
```

Note:
For an all-in-one "single" line command use the build_all shell script e.g.:

```
$ sh ./build.sh
```

Note:
For now includes only step 1 & 2 (that is, rake pull & rake build)
but not step 3 (that is, rake push).


```
$ rake push         # to git commit and push back all changes
```



Note:

For testing you can build country-specific datasets e.g. use:

```
$ rake build DATA=en
$ rake build DATA=de     # and so on
```

Note:

For "local" builds e.g. saving the reports to a temp folder use the
debug flag e.g.:

```
$ rake build recalc DEBUG=t DATA=en
```


### Update football.json Exports

Use

```
$ rake build json
```

### Dump logs

Use

```
$ rake logs DEBUG=t         # save to ./build/build.log
```

or

```
$ rake logs                 # save to ../logs/football.db/build.log
```


### All together

Use

```
$ rake build recalc json logs
```

same as

```
$ rake build
$ rake recalc
$ rake json
$ rake logs
```


### Troubleshooting - Use a Gemfile, that is, Locked Down Versions

If you have trouble with a new ActiceRecord version or something. Use a `Gemfile` and `bundle exec`
to lock down the version. Example:

`Gemfile`:

```
source 'https://rubygems.org'

gem 'rake'
gem 'activerecord', '4.2.7.1'
gem 'sportdb'
```

Use:

```
$ bundle install
```

to install all libraries (gems) and generate a Gemfile.lock. Now use:

```
$ bundle exec rake pull       ## to pull down all repos
$ bundle exec build           ## to build the database
$ bundle exec recalc
$ bundle exec json            ## and so on
```


