def gerrit_api_query(task)
  `curl -s 'https://gerrit.wikimedia.org/r/changes/?q=bug:'#{task}`
end

def gerrit_api_patch(patch)
  `curl -s 'https://gerrit.wikimedia.org/r/changes/#{patch}'`
end

def incidents_response(subset)
  require 'mediawiki_api'
  client = MediawikiApi::Client.new 'https://wikitech.wikimedia.org/w/api.php'
  client.action(
    :query,
    format: 'json',
    list: 'allpages',
    apprefix: "Incident documentation/#{subset}",
    aplimit: '1000'
  ).data
end

def incident_wikitext(incident)
  require 'mediawiki_api'
  client = MediawikiApi::Client.new 'https://wikitech.wikimedia.org/w/api.php'
  client.get_wikitext(incident).body
end

def patch_repository(patch)
  require 'selenium-webdriver'
  options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
  driver = Selenium::WebDriver.for(:firefox, options: options)
  patch_url = "https://gerrit.wikimedia.org/r/#/c/#{patch}/"
  driver.navigate.to patch_url
  sleep 1 while driver.current_url == patch_url
  repository = driver.current_url.split('/r/#/c/')[1].split('/+/')[0]
  driver.quit
  repository
end
