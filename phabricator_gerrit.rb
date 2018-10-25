api_token = ARGV[0]
phabricator_task = ARGV[1]
task_json = `curl https://phabricator.wikimedia.org/api/transaction.search \
-d api.token=#{api_token} \
-d objectIdentifier=#{phabricator_task}`

require 'json'
task_comments = JSON.parse(task_json)
gerritbot_comments = task_comments['result']['data'].select do |element|
  gerritbot = 'PHID-USER-idceizaw6elwiwm5xshb'
  element['authorPHID'] == gerritbot && !element['comments'].empty?
end

gerrit_repositories = gerritbot_comments.map do |element|
  element['comments'][0]['content']['raw'].split('[')[1].split('@')[0]
end.uniq

puts "#{phabricator_task}: #{gerrit_repositories}"
