def actionables(incidents, incidents_wikitext)
  incidents_actionables = {}
  incidents.each do |incident|
    incidents_actionables[incident] =
      actionables_wikitext(incidents_wikitext[incident])
  end
  incidents_actionables
end

def actionables_wikitext(incidents_wikitext)
  incidents_wikitext.split('Actionables')[1]
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

def phabricator_from_wikitext(wikitext)
  if wikitext.respond_to?(:scan)
    wikitext.scan(/\[\[phab:(T\d{5,6})\]\]/).flatten.uniq
  else
    []
  end
end

# not unit tested

# calls api#repository_from_gerrit
#
# arguments
#
# ['Incident documentation/20180312-Cache-text']
# { 'Incident documentation/20180312-Cache-text' => ['419090'] }
#
# returns
#
# { 'Incident documentation/20180312-Cache-text' => ['operations/puppet'] }
require_relative 'api'
def repos_patches(incidents, incidents_gerrit)
  incidents_gerrit_repository = {}
  incidents.each do |incident|
    incidents_gerrit_repository[incident] =
      repository_from_gerrit(incidents_gerrit[incident])
  end
  incidents_gerrit_repository
end

# converts json to hash
#
# arguments: json
#
# returns: hash
def task_comments(task_json)
  require 'json'
  JSON.parse(task_json)
end
