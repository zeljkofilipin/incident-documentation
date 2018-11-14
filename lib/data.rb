def actionables(incidents, incidents_wikitext)
  incidents_actionables = {}
  incidents.each do |incident|
    incidents_actionables[incident] =
      actionables_wikitext(incidents_wikitext[incident])
  end
  incidents_actionables
end

def actionables_tasks(incidents, incidents_actionables)
  incidents_phabricator = {}
  incidents.each do |incident|
    incidents_phabricator[incident] =
      phabricator_from_wikitext(incidents_actionables[incident])
  end
  incidents_phabricator
end

def actionables_wikitext(incidents_wikitext)
  incidents_wikitext.split('Actionables')[1]
end

def array_from_json(json)
  require 'json'
  JSON.parse(json)
end

def csv(incidents_and_repos)
  incidents_and_repos_csv = ''
  incidents_and_repos.each do |incident, repos|
    repos.each do |repo|
      incidents_and_repos_csv << "#{incident},#{repo}\n"
    end
  end
  incidents_and_repos_csv
end

def gerrit_api_json(task)
  gerrit_api_query(task).sub(")]}'\n", '')
end

def gerrit_from_wikitext(wikitext)
  if wikitext.respond_to?(:scan)
    wikitext.scan(/\[\[gerrit:(\d{6})\]\]/).flatten.uniq
  else
    []
  end
end

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

def incidents(subset)
  incidents_response(subset)['allpages'].map { |element| element['title'] }
end

def incidents_gerrit(incidents, incidents_actionables)
  incidents_gerrit = {}
  incidents.each do |incident|
    incidents_gerrit[incident] =
      gerrit_from_wikitext(incidents_actionables[incident])
  end
  incidents_gerrit
end

def incident_repos(incident)
  incident.map(&:values).flatten
end

def incidents_wikitext(incidents)
  incidents_wikitext = {}
  incidents.each do |incident|
    incidents_wikitext[incident] = incident_wikitext(incident)
  end
  incidents_wikitext
end

def patches_repositories(patches)
  patches.map do |patch|
    patch_repository(patch)
  end.uniq
end

def phabricator_from_wikitext(wikitext)
  if wikitext.respond_to?(:scan)
    wikitext.scan(/\[\[phab:(T\d{5,6})\]\]/).flatten.uniq
  else
    []
  end
end

def repos_patches(incidents, incidents_gerrit)
  incidents_gerrit_repository = {}
  incidents.each do |incident|
    incidents_gerrit_repository[incident] =
      patches_repositories(incidents_gerrit[incident])
  end
  incidents_gerrit_repository
end

def repo_patches_tasks(repos_patches, repos_tasks)
  (repos_patches + repos_tasks).uniq
end

def repos_patches_tasks(
  incidents, repos_from_patches, repos_from_tasks
)
  incidents_data = {}
  incidents.each do |incident|
    incidents_data[incident] =
      repo_patches_tasks(
        repos_from_patches[incident], repos_from_tasks[incident]
      )
  end
  incidents_data
end

def repos_tasks_summary(incidents, incidents_phabricator_repositories)
  incidents_phabricator_repository = {}
  incidents.each do |incident|
    incidents_phabricator_repository[incident] =
      incident_repos(incidents_phabricator_repositories[incident])
  end
  incidents_phabricator_repository
end

def repos_tasks_verbose(incidents_tasks)
  incidents_tasks_repos = {}
  incidents_tasks.each do |incident, tasks|
    incidents_tasks_repos[incident] = repositories_connected_to_tasks(tasks)
  end
  incidents_tasks_repos
end

def repositories_connected_to_task(task)
  json = gerrit_api_json(task)
  patches = array_from_json(json)
  patches.collect do |patch|
    patch['project']
  end.uniq
end

def repositories_connected_to_tasks(tasks)
  tasks.map do |task|
    { task => repositories_connected_to_task(task) }
  end
end
