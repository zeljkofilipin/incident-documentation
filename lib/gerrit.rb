# Arguments
#
# ["operations/puppet"]
#
# ["operations/puppet", "mediawiki/vagrant"]
#
# Returns
#
# ["operations/puppet", "mediawiki/vagrant"]
def repo_patches_tasks(repos_patches, repos_tasks)
  (repos_patches + repos_tasks).uniq
end

# Arguments
#
# ["Incident documentation/20180312-Cache-text"]
#
# {"Incident documentation/20180312-Cache-text"=>["operations/puppet"]}
#
# {"Incident documentation/20180312-Cache-text"=>
#   ["operations/puppet", "mediawiki/vagrant"]}
#
# Returns
#
# {"Incident documentation/20180312-Cache-text"=>
#   ["operations/puppet", "mediawiki/vagrant"]}
def repos_patches_tasks(
  incidents, repos_from_patches, repos_from_tasks
)
  incidents_data = {}
  incidents.each do |incident|
    incidents_data[incident] =
      repo_patches_tasks(
        repos_from_patches[incident], repos_from_tasks[incident]
      )
  end
  incidents_data
end
