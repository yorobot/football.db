## National Teams A-Z Index _({{ Team.where(club:false).count }})_{:.count}

.. <!-- add/fix: add category for starting w/ non-letters e.g. digits -->
.. <!-- todo: add entries for synonims - how?? use see xxx  why?  why not? -->

.. <!-- use helper e.g. navbar_az( topic ) or similar ?? -->
{% ('A'..'Z').each_with_index do |letter,i| %}
  {% if i > 0 then %} • {% end %} {{ letter }}
{% end %}


{% ('A'..'Z').each do |letter| %}

### {{ letter }}

{{ columns_begin }}
{% Team.where( "key like '#{letter.downcase}%'").where( club:false ).order(:key).each do |team| %}
  {{ render_team_idx( team, opts ) }}
{% end %}
{{ columns_end }}

{% end %}
