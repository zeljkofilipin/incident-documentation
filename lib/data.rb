def actionables_wikitext(incidents_wikitext)
  incidents_wikitext.split('Actionables')[1]
end

def actionables(incidents, incidents_wikitext)
  incidents_actionables = {}
  incidents.each do |incident|
    incidents_actionables[incident] =
      actionables_wikitext(incidents_wikitext[incident])
  end
  incidents_actionables
end
