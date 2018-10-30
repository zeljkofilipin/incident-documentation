require 'mediawiki_api'

year = '2018'
client = MediawikiApi::Client.new 'https://wikitech.wikimedia.org/w/api.php'
response = client.action :query,
                         format: 'json',
                         list: 'allpages',
                         apprefix: "Incident documentation/#{year}",
                         aplimit: '100'

incidents = response.data['allpages'].map { |element| element['title'] }
IO.write("incidents_#{year}.txt", incidents.join("\n"))
