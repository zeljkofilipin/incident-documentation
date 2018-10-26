def gerrit_repositories(gerritbot_comments)
  gerritbot_comments.map do |element|
    element['comments'][0]['content']['raw'].split('[')[1].split('@')[0]
  end.uniq.compact
end

def gerritbot_comments(task_comments)
  task_comments['result']['data'].select do |element|
    gerritbot = 'PHID-USER-idceizaw6elwiwm5xshb'
    element['authorPHID'] == gerritbot && !element['comments'].empty?
  end
end

def output(tasks_repos)
  require 'pp'
  pp tasks_repos
end

def task_comments(task_json)
  require 'json'
  JSON.parse(task_json)
end

def task_json(phabricator_task)
  api_token = ARGV[0]
  `curl https://phabricator.wikimedia.org/api/transaction.search \
  -d api.token=#{api_token} \
  -d objectIdentifier=#{phabricator_task}`
end

def tasks
  tasks_file = ARGV[1]
  File.readlines(tasks_file).map(&:strip)
end

def tasks_repos(tasks)
  tasks.map do |task|
    { task =>
      gerrit_repositories(
        gerritbot_comments(task_comments(task_json(task)))
      ) }
  end
end

output(tasks_repos(tasks))
