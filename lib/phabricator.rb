require_relative 'phabricator_gerrit'
incidents_phabricator_repository = {}
incidents.each do |incident|
  incidents_phabricator_repository[incident] =
    tasks_repos(incidents_phabricator[incident])
end
