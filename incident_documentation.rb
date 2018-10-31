require_relative 'lib/incidents_list'
incidents_subset = ARGV[1]
incidents = incidents(incidents_subset)
pp incidents

require_relative 'lib/wikitext'
wikitext = wikitext(incidents)
actionables = actionables(incidents, wikitext)

gerrit_repos_from_actionables = incidents_gerrit(incidents, actionables)
pp gerrit_repos_from_actionables

phabricator_tasks_from_actionables = actionables_tasks(incidents, actionables)
pp phabricator_tasks_from_actionables
