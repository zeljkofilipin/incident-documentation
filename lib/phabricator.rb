def repos_tasks_verbose(incidents, incidents_phabricator)
  incidents_phabricator_repository = {}
  incidents.each do |incident|
    incidents_phabricator_repository[incident] =
      tasks_repos(incidents_phabricator[incident])
  end
  incidents_phabricator_repository
end

# Accepts
# {"Incident documentation/20180312-Cache-text"=>
#  [{"T181315"=>["operations/puppet", "mediawiki/vagrant"]}, {"T96853"=>[]}]}
#
# Returns
# {"Incident documentation/20180312-Cache-text"=>
#   ["operations/puppet", "mediawiki/vagrant"]}
def incident_repos(incident)
  incident.map(&:values).flatten
end

def repos_tasks_summary(incidents, incidents_phabricator_repositories)
  incidents_phabricator_repository = {}
  incidents.each do |incident|
    incidents_phabricator_repository[incident] =
      incident_repos(incidents_phabricator_repositories[incident])
  end
  incidents_phabricator_repository
end
