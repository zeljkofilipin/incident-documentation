require_relative 'lib/api'
require_relative 'lib/data'

incidents_subset = ARGV[0]
puts "\nIncidents that start with #{incidents_subset}"
# Example: 20180312
# ["Incident documentation/20180312-Cache-text"]
pp incidents = incidents(incidents_subset)

wikitext = incidents_wikitext(incidents)
actionables = actionables_wikitexts(wikitext)

puts "\nGerrit patches in Actionables section"
# {"Incident documentation/20180312-Cache-text"=>["419090"]}
pp gerrit_patches_from_actionables = incidents_patches(actionables)

puts "\nGerrit repositories from Gerrit patches"
# {"Incident documentation/20180312-Cache-text"=>["operations/puppet"]}
gerrit_repos_from_patches =
  incidents_repos(gerrit_patches_from_actionables)
pp gerrit_repos_from_patches

puts "\nPhabricator tasks in Actionables section"
# {"Incident documentation/20180312-Cache-text"=>["T181315", "T96853"]}
pp phabricator_tasks_from_actionables =
     incidents_tasks(actionables)

puts "\nGerrit repositories from Phabricator tasks verbose"
# {"Incident documentation/20180312-Cache-text"=>
#   [{"T181315"=>["operations/puppet", "mediawiki/vagrant"]}, {"T96853"=>[]}]}
gerrit_repos_from_tasks_verbose =
  repos_tasks_verbose(phabricator_tasks_from_actionables)
pp gerrit_repos_from_tasks_verbose

puts "\nGerrit repositories from Phabricator tasks summary"
# {"Incident documentation/20180312-Cache-text"=>
#   ["operations/puppet", "mediawiki/vagrant"]}
gerrit_repos_from_tasks_summary =
  repos_tasks_summary(incidents, gerrit_repos_from_tasks_verbose)
pp gerrit_repos_from_tasks_summary

puts "\nGerrit repositories connected to an incident"
# {"Incident documentation/20180312-Cache-text"=>
#   ["operations/puppet", "mediawiki/vagrant"]}
gerrit_repos_from_patches_and_tasks =
  repos_patches_tasks(
    incidents, gerrit_repos_from_patches, gerrit_repos_from_tasks_summary
  )
pp gerrit_repos_from_patches_and_tasks

puts "\nGerrit repositories connected to an incident CSV"
puts csv(gerrit_repos_from_patches_and_tasks)
