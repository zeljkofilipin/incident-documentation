def wikitext(incidents)
  require 'mediawiki_api'
  client = MediawikiApi::Client.new 'https://wikitech.wikimedia.org/w/api.php'

  incidents_wikitext = {}
  incidents.each do |incident|
    incidents_wikitext[incident] = client.get_wikitext(incident).body
  end
  incidents_wikitext
end

def actionables(incidents, incidents_wikitext)
  incidents_actionables = {}
  incidents.each do |incident|
    incidents_actionables[incident] =
      incidents_wikitext[incident].split('Actionables')[1]
  end
  incidents_actionables
end

def gerrit_from_wikitext(wikitext)
  if wikitext.respond_to?(:scan)
    wikitext.scan(/\[\[gerrit:(\d{6})\]\]/).flatten.uniq
  else
    []
  end
end

def incidents_gerrit(incidents, incidents_actionables)
  incidents_gerrit = {}
  incidents.each do |incident|
    incidents_gerrit[incident] =
      gerrit_from_wikitext(incidents_actionables[incident])
  end
  incidents_gerrit
end

if $PROGRAM_NAME == __FILE__
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
