def gerrit_api_query(task)
  `curl 'https://gerrit.wikimedia.org/r/changes/?q=bug:'#{task}`
end

# arguments
#
# '20180312'
#
# returns
#
# ["Incident documentation/20180312-Cache-text"]
def incidents(subset)
  require 'mediawiki_api'
  client = MediawikiApi::Client.new 'https://wikitech.wikimedia.org/w/api.php'
  response = client.action :query,
                           format: 'json',
                           list: 'allpages',
                           apprefix: "Incident documentation/#{subset}",
                           aplimit: '1000'
  response.data['allpages'].map { |element| element['title'] }
end

# arguments
#
# ["419090"]
#
# returns
#
# ["operations/puppet"]
#
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def repository_from_gerrit(patches)
  require 'selenium-webdriver'
  options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
  patches.map do |patch|
    driver = Selenium::WebDriver.for(:firefox, options: options)
    patch_url = "https://gerrit.wikimedia.org/r/#/c/#{patch}/"
    driver.navigate.to patch_url
    sleep 1 while driver.current_url == patch_url
    repository = driver.current_url.split('/r/#/c/')[1].split('/+/')[0]
    driver.quit
    repository
  end.uniq
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

# arguments
#
# "T181315"
#
# returns
#
# {
#   "result":{
#     "data":[
#       {
#         "id":4507959,
#         "phid":"PHID-XACT-TASK-y2be6mni5ivq7oy",
#         "type":null,
#         "authorPHID":"PHID-USER-sai77mtxmpqnm6pycyvz",
#         "objectPHID":"PHID-TASK-bkf7tel6t5kgjabfk4r3",
#         "dateCreated":1534446481,
#         "dateModified":1534446481,
#         "comments":[
#
#         ],
#         "fields":{
#
#         }
#       },
#   ...
#   "error_code":null,
#   "error_info":null
# }
def task_json(phabricator_task)
  api_token = ARGV[0]
  `curl \
  -s \
  https://phabricator.wikimedia.org/api/transaction.search \
  -d api.token=#{api_token} \
  -d objectIdentifier=#{phabricator_task}`
end

# arguments
#
# ["Incident documentation/20180312-Cache-text"]
#
# returns
#
# {"Incident documentation/20180312-Cache-text"=>
#   "This is a draft, edit heavily please. (...)"}
def wikitext(incidents)
  require 'mediawiki_api'
  client = MediawikiApi::Client.new 'https://wikitech.wikimedia.org/w/api.php'

  incidents_wikitext = {}
  incidents.each do |incident|
    incidents_wikitext[incident] = client.get_wikitext(incident).body
  end
  incidents_wikitext
end
