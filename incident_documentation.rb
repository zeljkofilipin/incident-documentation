require_relative 'lib/incidents_list.rb'

incidents_subset = ARGV[1]
pp incidents(incidents_subset)
