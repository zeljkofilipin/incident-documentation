def actionables(wikitext)
  wikitext.split('Actionables')[1]
end

def incidents_actionables(incidents_wikitext)
  incidents_wikitext.transform_values do |wikitext|
    actionables(wikitext)
  end
end

def json(almost_json)
  almost_json.sub(")]}'\n", '')
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
  json(gerrit_api_query(task))
end

def patches(wikitext)
  if wikitext.respond_to?(:scan)
    wikitext.scan(/\[\[gerrit:(\d{6})\]\]/).flatten.uniq
  else
    []
  end
end

def incidents(subset)
  incidents_response(subset)['allpages'].map { |element| element['title'] }
end

def incidents_patches(incidents_actionables)
  incidents_patches = {}
  incidents_actionables.each do |incident, actionables|
    incidents_patches[incident] =
      patches(actionables)
  end
  incidents_patches
end

def incident_repos(incident)
  incident.map(&:values).flatten
end

def incidents_repos(incidents_patches)
  incidents_repos = {}
  incidents_patches.each do |incident, patches|
    incidents_repos[incident] =
      patches_repositories(patches)
  end
  incidents_repos
end

def incidents_tasks(incidents_actionables)
  incidents_tasks = {}
  incidents_actionables.each do |incident, actionables|
    incidents_tasks[incident] =
      phabricator_from_wikitext(actionables)
  end
  incidents_tasks
end

def incidents_wikitext(incidents)
  incidents_wikitext = {}
  incidents.each do |incident|
    incidents_wikitext[incident] = incident_wikitext(incident)
  end
  incidents_wikitext
end

def parse_json(json)
  require 'json'
  JSON.parse(json)
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

def incidents_tasks_repos(incidents_tasks)
  incidents_tasks.transform_values do |tasks|
    repositories_connected_to_tasks(tasks)
  end
end

def repositories_connected_to_task(task)
  json = gerrit_api_json(task)
  patches = parse_json(json)
  patches.collect do |patch|
    patch['project']
  end.uniq
end

def repositories_connected_to_tasks(tasks)
  tasks.map do |task|
    { task => repositories_connected_to_task(task) }
  end
end

require_relative 'api'
def patch_repository(patch)
  response = gerrit_api_patch(patch)
  json = json(response)
  parse_json(json)['project']
end
