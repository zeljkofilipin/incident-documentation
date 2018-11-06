def gerrit_repositories(gerritbot_comments)
  gerritbot_comments.map do |element|
    element['comments'][0]['content']['raw'].split('[')[1].split('@')[0]
  end.uniq.compact
end

def gerritbot_comments(task_comments)
  return [] unless task_comments['result']

  task_comments['result']['data'].select do |element|
    gerritbot = 'PHID-USER-idceizaw6elwiwm5xshb'
    element['authorPHID'] == gerritbot && !element['comments'].empty?
  end
end

def tasks_repos(tasks)
  tasks.map do |task|
    { task =>
      gerrit_repositories(
        gerritbot_comments(task_comments(task_json(task)))
      ) }
  end
end

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
