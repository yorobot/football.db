
## Stadiums _({{ Ground.count }})_{: .count}

{% Continent.all.each do |continent| %}

.. <!-- fix: use unique anchor -- add stadium e.g. stadiums-europe? or similar -->
#### {{ continent.title }}
{: #{{ urlify( continent.title ) }} }

{% continent.countries.order(:title).each do |country|
      next if country.grounds.count == 0                     %}

**{{ country.title }}**  _({{ country.grounds.count }})_{: .count}

  {% country.grounds.order('capacity DESC').each do |ground| %}
    {{ render_ground( ground, opts ) }}
  {% end %}

{% end %}

{% end %}<!-- each continent -->
