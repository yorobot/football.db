..
..
{{ team_title( team ) }}  ++
{{ " (#{team.code})" if team.code.present? }} ++
{{ " -- #{team.city.title}" if team.city_id.present? }} ++
_#{{ team.key }}_{: .key} ++
<br>
{: .team #{{team.key}} }
