require 'mediawiki_api'

year = '2018'
client = MediawikiApi::Client.new 'https://wikitech.wikimedia.org/w/api.php'
incidents = File.readlines("incidents_list_#{year}.txt").map(&:strip)

incidents_wikitext = {}
incidents.each do |incident|
  incidents_wikitext[incident] = client.get_wikitext(incident).body
end

incidents_actionables = {}
incidents.each do |incident|
  incidents_actionables[incident] =
    incidents_wikitext[incident].split('Actionables')[1]
end

def gerrit_from_wikitext(wikitext)
  if wikitext.respond_to?(:scan)
    wikitext.scan(/\[\[gerrit:(\d{6})\]\]/).flatten.uniq
  else
    []
  end
end
incidents_gerrit = {}
incidents.each do |incident|
  incidents_gerrit[incident] =
    gerrit_from_wikitext(incidents_actionables[incident])
end
pp incidents_gerrit

def phabricator_from_wikitext(wikitext)
  if wikitext.respond_to?(:scan)
    wikitext.scan(/\[\[phab:(T\d{5,6})\]\]/).flatten.uniq
  else
    []
  end
end
incidents_phabricator = {}
incidents.each do |incident|
  incidents_phabricator[incident] =
    phabricator_from_wikitext(incidents_actionables[incident])
end

def repository_from_gerrit(patches)
  require 'selenium-webdriver'
  patches.map do |patch|
    driver = Selenium::WebDriver.for :firefox
    driver.navigate.to "https://gerrit.wikimedia.org/r/#/c/#{patch}/"
    sleep 2
    repository = driver.current_url.split('/r/#/c/')[1].split('/+/')[0]
    driver.quit
    repository
  end
end
incidents_gerrit_repository = {}
incidents.each do |incident|
  incidents_gerrit_repository[incident] =
    repository_from_gerrit(incidents_gerrit[incident])
end
pp incidents_gerrit_repository
