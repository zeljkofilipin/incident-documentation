require_relative 'lib/incidents_list'
incidents_subset = ARGV[1]
incidents = incidents(incidents_subset)
pp incidents

require_relative 'lib/wikitext'
wikitext = wikitext(incidents)
pp wikitext

actionables = actionables(incidents, wikitext)
pp actionables
