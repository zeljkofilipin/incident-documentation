def actionables_tasks(incidents, incidents_actionables)
  incidents_phabricator = {}
  incidents.each do |incident|
    incidents_phabricator[incident] =
      phabricator_from_wikitext(incidents_actionables[incident])
  end
  incidents_phabricator
end
