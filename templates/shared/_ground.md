 {{ ground_title( ground ) }} ++
 {{ " (#{ground.since})"  if ground.since.present? }} ++
 {{ " max. #{ground.capacity} attendance " if ground.capacity.present? }} ++
 {{ "; #{ground.address} "  if ground.address.present? }} ++
  _#{{ ground.key }}_{: .key} ++
 {{ " -- #{ground.city.title}" if ground.city_id.present? }} ++
 <br>
