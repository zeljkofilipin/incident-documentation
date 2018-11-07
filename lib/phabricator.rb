def repos_tasks_summary(incidents, incidents_phabricator_repositories)
  incidents_phabricator_repository = {}
  incidents.each do |incident|
    incidents_phabricator_repository[incident] =
      incident_repos(incidents_phabricator_repositories[incident])
  end
  incidents_phabricator_repository
end
