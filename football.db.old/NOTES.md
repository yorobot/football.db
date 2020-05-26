# Tips n Tricks


To install and freeze the version of your gems you use a Gemfile.
Example:

```
source 'https://rubygems.org'

gem 'activerecord', '~> 4.2.0'
gem 'activesupport', '~> 4.2.0'    ### check not really needed ?? pulled in by activerecord ??

gem 'worlddb', '~> 2.2.1'
gem 'sportdb', '~> 1.11.0'
```



## Setup Notes on Windows

**Add Desktop Shortcut**

Ruby Console/Shell:

Note: setup_environment.bat requires the <RAILS_INSTALLER_DIR> as its first argument e.g.

Use <RAILS_INSTALLER_DIR>\Ruby2.1.0\setup_environment.bat <RAILS_INSTALLER_DIR> e.g.:

<RAILS_INSTALLER_DIR> => c:\prg\ri\v310

Use cmd with /K option  (see cmk /? for help on options) e.g.

/K  =>  Carries out the command specified by string but remains

All together now:

$ cmd.exe /K c:\prg\ri\v310\Ruby2.1.0\setup_environment.bat c:\prg\ri\v310\Ruby2.1.0
