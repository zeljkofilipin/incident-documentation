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

def wikitext(incidents)
  require 'mediawiki_api'
  client = MediawikiApi::Client.new 'https://wikitech.wikimedia.org/w/api.php'

  incidents_wikitext = {}
  incidents.each do |incident|
    incidents_wikitext[incident] = client.get_wikitext(incident).body
  end
  incidents_wikitext
end
