##########
#  Check (Auto-)Conf(igurations) in Datasets
#
#  to run use:
#    ruby ./check_conf.rb
#

#########
# todos/check:
#
# - [ ]  check for matches WITHOUT score
#          report missing score as errors - why? why not?
# - [ ]  rename to lint
#          or check_match_auto or lint_match_auto or such??




require_relative 'boot'



## champions league mods
mods = {
'Arsenal   | Arsenal FC'    => 'Arsenal, ENG',
'Liverpool | Liverpool FC'  => 'Liverpool, ENG',
'Barcelona'                 => 'Barcelona, ESP',
'Valencia'                  => 'Valencia, ESP'
}


eng = "#{OPENFOOTBALL_DIR}/england"
de  = "#{OPENFOOTBALL_DIR}/deutschland"
at  = "#{OPENFOOTBALL_DIR}/austria"
es  = "#{OPENFOOTBALL_DIR}/espana"
fr  = "#{OPENFOOTBALL_DIR}/france"
it  = "#{OPENFOOTBALL_DIR}/italy"
ru  = "#{OPENFOOTBALL_DIR}/russia"

br  = "#{OPENFOOTBALL_DIR}/brazil"
mx  = "#{OPENFOOTBALL_DIR}/mexico"

world = "#{OPENFOOTBALL_DIR}/world"

cl  = "#{OPENFOOTBALL_DIR}/europe-champions-league"

euro     = "#{OPENFOOTBALL_DIR}/euro-cup"
worldcup = "#{OPENFOOTBALL_DIR}/world-cup"


datasets = {
  'eng' => [eng],
  'de'  => [de],
  'at'  => [at],
  'es'  => [es],
  'fr'  => [fr],
  'it'  => [it],
  'ru'  => [ru],   ## note: use english fallback / default lang for now

  'br'  => [br],
  'mx'  => [mx],

  'world' => [world],

  'cl'  => [cl, { mods: mods }],

  'euro'  => [euro],
  'worldcup' => [worldcup],
}


def print_errors( errors )
  if errors.size > 0
    puts "#{errors.size} error(s) / warn(s):"
    errors.each do |error|
      puts "!! ERROR: #{error}"
    end
  else
    puts "#{errors.size} errors / warns"
  end
end


if ARGV.size > 0

  dataset = datasets[ ARGV[0] ]

  path   = dataset[0]
  kwargs = dataset[1] || {}

  buf, errors = SportDb::PackageLinter.lint( path, **kwargs )
  puts buf
  puts
  print_errors( errors )

## save
# out_path = "#{path}/.build/conf.txt"
out_path = "./tmp/#{ARGV[0]}.conf.txt"
File.open( out_path , 'w:utf-8' ) do |f|
 f.write( buf )
end

else    ## check all
errors_by_dataset = []

datasets.values.each do |dataset|
  path   = dataset[0]
  kwargs = dataset[1] || {}

  buf, errors = SportDb::PackageLinter.lint( path, **kwargs )
  puts buf

  errors_by_dataset << [File.basename(path), errors]
end


errors_by_dataset.each do |rec|
  dataset = rec[0]
  errors  = rec[1]

  puts
  puts "==== #{dataset} ===="

  print_errors( errors )
end
end

puts "bye"


