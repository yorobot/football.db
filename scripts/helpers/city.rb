# encoding: utf-8

def city_pop( city )
  buf = ''
  pops = []

  pops << number_with_delimiter( city.pop )           if city.pop.present?
  pops << "(#{number_with_delimiter(city.popm)})"     if city.popm.present?

  buf << " _pop #{pops.join(' ')}_{:.pop}"  if pops.size > 0
  buf
end

