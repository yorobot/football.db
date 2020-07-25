##########
#  Check Conf(igurations) in Datasets
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


eng = "#{OPENFOOTBALL_DIR}/england"   ## en
de  = "#{OPENFOOTBALL_DIR}/deutschland"   ## de
at  = "#{OPENFOOTBALL_DIR}/austria"   ## de
es  = "#{OPENFOOTBALL_DIR}/espana"    ## es
fr  = "#{OPENFOOTBALL_DIR}/france"    ## fr
it  = "#{OPENFOOTBALL_DIR}/italy"     ## it
ru  = "#{OPENFOOTBALL_DIR}/russia"

br  = "#{OPENFOOTBALL_DIR}/brazil"
mx  = "#{OPENFOOTBALL_DIR}/mexico"

cl  = "#{OPENFOOTBALL_DIR}/europe-champions-league"

euro  = "#{OPENFOOTBALL_DIR}/euro-cup"
world = "#{OPENFOOTBALL_DIR}/world-cup"


datasets = {
  'eng' => [eng, { lang: 'en' }],
  'de'  => [de,  { lang: 'de' }],
  'at'  => [at,  { lang: 'de' }],
  'es'  => [es,  { lang: 'es' }],
  'fr'  => [fr,  { lang: 'fr' }],
  'it'  => [it,  { lang: 'it' }],
  'ru'  => [ru,  { lang: 'en' }],   ## note: use english fallback / default lang for now

  'br'  => [br,  { lang: 'pt' }],
  'mx'  => [mx,  { lang: 'es' }],

  'cl'  => [cl,  { lang: 'en', mods: mods }],

  'euro'  => [euro,  { lang: 'en' }],
  'world' => [world, { lang: 'en' }],
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
  kwargs = dataset[1]

  buf, errors = SportDb::PackageLinter.lint( path, exclude: /archive/,
                                      **kwargs )
  puts buf
  puts
  print_errors( errors )

## save
# out_path = "#{path}/.build/conf.txt"
out_path = "./tmp/conf.txt"
File.open( out_path , 'w:utf-8' ) do |f|
 f.write( buf )
end

else    ## check all
errors_by_dataset = []

datasets.values.each do |dataset|
  path   = dataset[0]
  kwargs = dataset[1]

  buf, errors = SportDb::PackageLinter.lint( path, exclude: /archive/,
                                      **kwargs )
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


