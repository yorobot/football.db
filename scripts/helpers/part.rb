# encoding: utf-8

##########################
# part helpers



def render_world_tree_for( o, opts={} )

  ### fix: move to helpers/world.rb  and rename to world_tree_for (remove render!!)

  buf = ''

  values = []

  ## check special case
  #  o is SportDb::Model::Team  and  national team (e.g. club:false)
  if o.kind_of?( Team ) && o.club == false
    #  skip country/region/city only show only continent if present
    values << o.country.continent.title   if o.country.continent_id.present?
  else
    if o.city_id.present?    ## todo/fix: can we just use o.city? or o.city.present?
      values << o.city.title
      values << o.city.region.title              if o.city.region_id.present?
      values << o.city.country.title
      values << o.city.country.continent.title   if o.city.country.continent_id.present?
    else
      values << o.country.title
      values << o.country.continent.title   if o.country.continent_id.present?
    end
  end

  buf << values.join(', ')
  buf
end


#####
# todo: find a better name for ender_toc_countries ??


def render_toc_countries( countries, opts={} )
  buf = ''
  countries.each do |country|
    #<!-- fix: add to models -> countries_w_breweries_or_beers ?? -->
    # <!-- todo: use helper e.g. has_beers_or_breweries? or similar  ?? -->
    national_teams_count = country.teams.where(club:false).count  # fix: add assoc national_teams !!!
    clubs_count          = country.teams.where(club:true).count   # fix: add assoc clubs !!!
    leagues_count        = country.leagues.count
    ## events_count  = country.events.count  <!-- fix: add to sportdb gem -->
    
    # skip country w/o teams or leagues
    next if national_teams_count == 0 && clubs_count == 0 && leagues_count == 0
    
    buf << link_to_country( country, opts )
    buf << " -- "
 
    counts = []
    counts << "_#{national_teams_count} National Team_{:.count}"  if national_teams_count > 0
    counts << "_#{clubs_count} Clubs_{:.count}"        if clubs_count > 0
    counts << "_#{leagues_count} Leagues_{:.count} "   if leagues_count > 0
    
    buf << counts.join(', ')
    buf << "  <br>"
    buf << "\n"
  end
  buf
end


def render_teams( teams, opts={} )
  buf = ''
  teams.each do |team|
    buf << render_team( team, opts )
  end
  buf
end


### reuse/cleanup
# - use common render_part(ial)  or similar
# - allow check for if is collection or single record - how??

def render_ground( ground, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_ground.md' )
  render_erb_template( tmpl, binding )
end

def render_team( team, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_team.md' )
  render_erb_template( tmpl, binding )
end

def render_team_idx( team, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_team-idx.md' )
  render_erb_template( tmpl, binding )
end
