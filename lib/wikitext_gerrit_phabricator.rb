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
incidents_gerrit_repository = {}
incidents.each do |incident|
  incidents_gerrit_repository[incident] =
    repository_from_gerrit(incidents_gerrit[incident])
end
pp incidents_gerrit_repository

require_relative 'phabricator_gerrit'
incidents_phabricator_repository = {}
incidents.each do |incident|
  incidents_phabricator_repository[incident] =
    tasks_repos(incidents_phabricator[incident])
end
pp incidents_phabricator_repository