def repository_from_gerrit(patches)
  require 'selenium-webdriver'
  patches.map do |patch|
    driver = Selenium::WebDriver.for :firefox
    driver.navigate.to "https://gerrit.wikimedia.org/r/#/c/#{patch}/"
    sleep 2
    repository = driver.current_url.split('/r/#/c/')[1].split('/+/')[0]
    driver.quit
    repository
  end.uniq
end

def repos_patches(incidents, incidents_gerrit)
  incidents_gerrit_repository = {}
  incidents.each do |incident|
    incidents_gerrit_repository[incident] =
      repository_from_gerrit(incidents_gerrit[incident])
  end
  incidents_gerrit_repository
end

# Arguments
#
# ["operations/puppet"]
#
# ["operations/puppet", "mediawiki/vagrant"]
#
# Returns
#
# ["operations/puppet", "mediawiki/vagrant"]
def repo_patches_tasks(repos_patches, repos_tasks)
  (repos_patches + repos_tasks).uniq
end

# Arguments
#
# ["Incident documentation/20180312-Cache-text"]
#
# {"Incident documentation/20180312-Cache-text"=>["operations/puppet"]}
#
# {"Incident documentation/20180312-Cache-text"=>
#   ["operations/puppet", "mediawiki/vagrant"]}
#
# Returns
#
# {"Incident documentation/20180312-Cache-text"=>
#   ["operations/puppet", "mediawiki/vagrant"]}
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
