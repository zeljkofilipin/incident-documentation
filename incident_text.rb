require 'mediawiki_api'

year = 'test'
client = MediawikiApi::Client.new 'https://wikitech.wikimedia.org/w/api.php'
incidents = File.readlines("incidents_#{year}.txt").map(&:strip)

incidents_wikitext = {}
incidents.each do |incident|
  incidents_wikitext[incident] = client.get_wikitext(incident).body
end

incidents_actionables = {}
incidents.each do |incident|
  incidents_actionables[incident] =
    incidents_wikitext[incident].split('Actionables')[1]
end
pp incidents_actionables
