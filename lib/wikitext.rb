def wikitext(incidents)
  require 'mediawiki_api'
  client = MediawikiApi::Client.new 'https://wikitech.wikimedia.org/w/api.php'

  incidents_wikitext = {}
  incidents.each do |incident|
    incidents_wikitext[incident] = client.get_wikitext(incident).body
  end
  incidents_wikitext
end

if $PROGRAM_NAME == __FILE__
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
end
