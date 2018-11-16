require_relative 'lib/api'
require_relative 'lib/data'

incidents_subset = ARGV[0]
puts "\nIncidents that start with #{incidents_subset}"
# Example: 20180312
# ["Incident documentation/20180312-Cache-text"]
pp incidents = incidents(incidents_subset)

incidents_wikitext = incidents_wikitext(incidents)
incidents_actionables = incidents_actionables(incidents_wikitext)

puts "\nGerrit patches in Actionables section"
# {"Incident documentation/20180312-Cache-text"=>["419090"]}
pp incidents_patches = incidents_patches(incidents_actionables)

puts "\nGerrit repositories from Gerrit patches"
# {"Incident documentation/20180312-Cache-text"=>["operations/puppet"]}
pp incidents_repos = incidents_repos(incidents_patches)

puts "\nPhabricator tasks in Actionables section"
# {"Incident documentation/20180312-Cache-text"=>["T181315", "T96853"]}
pp incidents_tasks = incidents_tasks(incidents_actionables)

puts "\nGerrit repositories from Phabricator tasks verbose"
# {"Incident documentation/20180312-Cache-text"=>
#   [{"T181315"=>["operations/puppet", "mediawiki/vagrant"]}, {"T96853"=>[]}]}
pp incidents_tasks_repos = incidents_tasks_repos(incidents_tasks)

puts "\nGerrit repositories from Phabricator tasks summary"
# {"Incident documentation/20180312-Cache-text"=>
#   ["operations/puppet", "mediawiki/vagrant"]}
gerrit_repos_from_tasks_summary =
  repos_tasks_summary(incidents, incidents_tasks_repos)
pp gerrit_repos_from_tasks_summary

puts "\nGerrit repositories connected to an incident"
# {"Incident documentation/20180312-Cache-text"=>
#   ["operations/puppet", "mediawiki/vagrant"]}
gerrit_repos_from_patches_and_tasks =
  repos_patches_tasks(
    incidents, incidents_repos, gerrit_repos_from_tasks_summary
  )
pp gerrit_repos_from_patches_and_tasks

puts "\nGerrit repositories connected to an incident CSV"
puts csv(gerrit_repos_from_patches_and_tasks)
