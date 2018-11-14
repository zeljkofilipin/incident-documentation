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
