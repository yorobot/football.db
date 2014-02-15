## Contents

[Leagues & Tournaments](#events) •
[World Tour](#tour) •
[Stadiums](#stadiums) •
[A-Z National Teams, Clubs](#az)


.. <!-- (re)use partial for events ??? -->

### Leagues & Tournaments _({{ Event.count }})_{: .count}
{: #events}

{% League.all.each do |league|
   if league.events.count > 0 %}
| ++
   {{ league.title }} ++
  _#{{ league.key }}_{: .key} ++
| ++
   _({{ league.events.count }})_{: .count}  ++
| ++
   {% league.events.each_with_index do |event,index| %} ++
          {{ '•' if index > 0 }} ++
          {{ link_to_event( event, season: true ) }}  ++   <!-- fix: use opts -->
   {% end %}  ++
| ++
    {% if league.country.present? %} ++
      {{ link_to_country( league.country ) }}  ++  <!-- fix: use opts  -->
    {% end %} ++
|
{% end %}
{% end %}




### World Tour
{: #tour}

{{ continents_navbar }}


{% Continent.all.each do |continent| %}


#### {{ continent.title }}
{: #{{ urlify( continent.title ) }} }

  {{ columns_begin( columns: 3 ) }}
  {{ render_toc_countries( continent.countries.order(:title), opts ) }}
  {{ columns_end() }}

{% end %}<!-- each continent -->


### Stadiums
{: #stadiums}
[Stadiums](stadiums.html) _({{Ground.count}})_{: .count} <br>


### A-Z National Teams, Clubs
{: #az}

<!-- fix: for all-in-one page version use/check opts :inline -->
[National Teams A-Z Index](national-teams.html) _({{Team.where(club:false).count}})_{: .count} <br>
[Clubs A-Z Index](clubs.html) _({{Team.where(club:true).count}})_{: .count} <br>

<!-- [Leagues & Tournaments A-Z Index](events.html) _({{Event.count}})_{: .count} <br> -->
