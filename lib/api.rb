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
