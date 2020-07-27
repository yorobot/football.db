# Notes

## Fix

```
3 error(s) / warn(s):
!! ERROR: pacific/australia/2018-19/1-aleague.txt[2] - ERROR: team missing / not found >a.e.t.  Melbourne City FC<
!! ERROR: pacific/australia/2018-19/1-aleague.txt[2] - ERROR: team missing / not found >pen. 0-0 a.e.t.  Sydney FC<
!! ERROR: pacific/australia/2018-19/1-aleague.txt[2] - ERROR: team missing / not found >pen. 3-3 a.e.t.  Adelaide United<
lint_world: done in 97.647779 sec(s)

add a Timer object
Timer
start / stop
Timer.total or diff ??

class Numeric
  def duration
    secs  = self.to_int
    mins  = secs / 60
    hours = mins / 60
    days  = hours / 24

    if days > 0
      "#{days} days and #{hours % 24} hours"
    elsif hours > 0
      "#{hours} hours and #{mins % 60} minutes"
    elsif mins > 0
      "#{mins} minutes and #{secs % 60} seconds"
    elsif secs >= 0
      "#{secs} seconds"
    end
  end
end

see https://stackoverflow.com/questions/1679266/can-ruby-print-out-time-difference-duration-readily
```


## Todos

- [ ] rename (gitti) setup.rb script to sync.rb  - why? why not?
- [ ] improve reports in ./build
  - [ ]  check for national teams!!  - do NOT use clubs.txt for world cup, euro, etc.
  - [ ]  check for int'l clubs!!!  - add country to club name (add country report - clubs by countries?)


