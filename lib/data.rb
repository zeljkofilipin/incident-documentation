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
  incidents_actionables.transform_values do |actionables|
    patches(actionables)
  end
end

def incident_repos(incident)
  incident.map(&:values).flatten
end

def incidents_repos(incidents_patches)
  incidents_patches.transform_values do |patches|
    repositories(patches)
  end
end

def incidents_tasks(incidents_actionables)
  incidents_actionables.transform_values do |actionables|
    tasks(actionables)
  end
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

def repositories(patches)
  patches.map do |patch|
    patch_repository(patch)
  end.uniq
end

def tasks(wikitext)
  if wikitext.respond_to?(:scan)
    wikitext.scan(/\[\[phab:(T\d{5,6})\]\]/).flatten.uniq
  else
    []
  end
end

def uniq_repos(repos_patches, repos_tasks)
  (repos_patches + repos_tasks).uniq
end

def incidents_repos_uniq(
  incidents_repos_patches, incidents_repos_tasks
)
  incidents_repos_patches.merge(
    incidents_repos_tasks
  ) do |_, repos_patches, repos_tasks|
    uniq_repos(repos_patches, repos_tasks)
  end
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
