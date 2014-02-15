# encoding: utf-8

##########################
# part helpers


def continents_navbar    # use render? or just call method/helper continent_navbar ??
  buf = ''
  Continent.all.each_with_index do |continent,i|
    buf << ' • ' if i > 0
    buf << link_to( continent.title, "##{urlify(continent.title)}" )
  end
  buf
end


def regions_navbar_for_country( country )
  buf = ''
  region_count = 0
  country.regions.each do |region|
    buf << ' • '  if region_count > 0
    buf << link_to( region.title, "##{country.key}-#{region.key}" )
    buf << " _(#{region.cities.count})_{:.count}"
    region_count += 1
  end

  # check for uncategorized cities (no region)
  uncategorized_cities_count = country.cities.where( 'region_id is null' ).count
  if uncategorized_cities_count > 0
    buf << ' • '  if region_count > 0
    buf << '**Uncategorized**'
    buf << " _(#{uncategorized_cities_count})_{:.count}"
    region_count += 1
  end

  # note: do NOT add navbar if only one entry (it's redundant)
  if region_count < 2
    ''
  else
    buf
  end
end



def cities_navbar_for_region( region )
  buf = ''
  city_count = 0
  region.cities.order(:title).each do |city|
    buf << ' • '  if city_count > 0
    buf << link_to( city.title, "##{city.key}" )
    city_count += 1
  end

  # note: do NOT add navbar if only one entry (it's redundant)
  if city_count < 2
    ''
  else
    buf
  end
end
