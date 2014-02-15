## {{ country.title }}   ++
   ({{ country.code }})  ++
   -                     ++
   {{ country.teams.where(club:true).count }} Clubs
   {: #{{ country.key }} }


.. <!-- add leagues -->

{% country.leagues.each_with_index do |league,i| %}
  {{ ' • ' if i > 0 }}  ++
  {{ league.title }}  ++
  _#{{ league.key }}_{: .key}
{% end %}


 .. <!-- add intra-page links for regions here -->
 <!-- change to navbar_regions_for_country ?? -->
 {{ regions_navbar_for_country( country ) }}


  .. <!-- list breweries w/o (missing) region -->
  .. <!-- todo/fix: change name to uncategorized_breweries -->
{% teams_missing_cities = country.teams.where( 'city_id is null' )
   if teams_missing_cities.count > 0
 %}

### Uncategorized _({{ teams_missing_cities.count }})_{:.count}

  {{ render_teams( teams_missing_cities.order(:title) ) }}
{% end %}


  .. <!-- list regions w/ breweries -->
{% country.regions.each do |region| %}

### {{ region.title_w_synonyms }}  ++
    _({{ region.teams.count }})_{:.count}
{: #{{ country.key }}-{{ region.key }} }

 .. <!-- add intra-page cities for regions links here -->
 <!-- change to navbar_cities_for_region( region ) ??? -->
 <!-- cities_navbar_for_region( region ) -->

 {{ columns_begin }}
 {{ render_teams( region.teams.order(:title) ) }}
 {{ columns_end }}

{% end %} <!-- each region -->
