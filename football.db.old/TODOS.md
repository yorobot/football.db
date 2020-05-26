# ToDos


## Stats

- [ ] fix build_teams   - double defined; score1et

```
def build_stats
  buf = ''
  buf << build_leagues
  ##  buf << build_teams    - note: build_teams (re)defined w/ args in team.rb!!! fix
  buf << build_events
  buf << build_logs
  buf
end
```
