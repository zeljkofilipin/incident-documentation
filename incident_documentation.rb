require_relative 'lib/wikitech'
incidents_subset = ARGV[1]
pp incidents = incidents(incidents_subset)

require_relative 'lib/wikitext'
wikitext = wikitext(incidents)
actionables = actionables(incidents, wikitext)

pp gerrit_repos_from_actionables = incidents_gerrit(incidents, actionables)

require_relative 'lib/gerrit'
gerrit_repos_from_patches =
  repos_patches(incidents, gerrit_repos_from_actionables)
pp gerrit_repos_from_patches

pp phabricator_tasks_from_actionables =
     actionables_tasks(incidents, actionables)

require_relative 'lib/phabricator'
gerrit_repos_from_tasks =
  repos_tasks(incidents, phabricator_tasks_from_actionables)
pp gerrit_repos_from_tasks
