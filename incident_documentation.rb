# Incidents that start with 20180312
# ["Incident documentation/20180312-Cache-text"]
require_relative 'lib/wikitech'
incidents_subset = ARGV[1]
pp incidents = incidents(incidents_subset)

require_relative 'lib/wikitext'
wikitext = wikitext(incidents)
actionables = actionables(incidents, wikitext)

# Gerrit patches in Actionables section
# {"Incident documentation/20180312-Cache-text"=>["419090"]}
pp gerrit_patches_from_actionables = incidents_gerrit(incidents, actionables)

# Gerrit repositories from Gerrit patches
# {"Incident documentation/20180312-Cache-text"=>["operations/puppet"]}
require_relative 'lib/gerrit'
gerrit_repos_from_patches =
  repos_patches(incidents, gerrit_patches_from_actionables)
pp gerrit_repos_from_patches

# Phabricator tasks in Actionables section
# {"Incident documentation/20180312-Cache-text"=>["T181315", "T96853"]}
pp phabricator_tasks_from_actionables =
     actionables_tasks(incidents, actionables)

# Gerrit repositories from Phabricator tasks
# {"Incident documentation/20180312-Cache-text"=>
#   [{"T181315"=>["operations/puppet", "mediawiki/vagrant"]}, {"T96853"=>[]}]}
require_relative 'lib/phabricator'
gerrit_repos_from_tasks =
  repos_tasks(incidents, phabricator_tasks_from_actionables)
pp gerrit_repos_from_tasks
