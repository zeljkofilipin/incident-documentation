# rubocop:disable Metrics/BlockLength, Metrics/LineLength
require_relative '../lib/data'

RSpec.describe 'incident report' do
  incidents = ['Incident documentation/20180312-Cache-text']
  incidents_patches = { 'Incident documentation/20180312-Cache-text' => ['419090'] }
  actionables_wikitext =
    "==\n" \
    "*Continue ongoing related investigations in [[phab:T181315]]\n" \
    "*Set up paging alerting on backend connections piling up (TBD)\n" \
    "*Move backend restarts from weekly to bi-weekly (done in [[gerrit:419090]])\n" \
    '*Long term: Move to ATS as caching solution for cache backends ([[phab:T96853]])'
  context 'wikitext' do
    actionables_wikitexts = { 'Incident documentation/20180312-Cache-text' => actionables_wikitext }
    incident_wikitext =
      "This is a draft, edit heavily please.\n" \
      "\n" \
      "==Summary==\n" + "From 05:08 to 08:32 UTC on Monday, 12 March 2018 the number of user-facing 503 error messages increased due to piling backend connections in several CDN nodes (cp3011,cp3033 and cp3042) on [[Esams cluster|esams]] datacenter.  The root cause of this incident is unknown, but is likely related to known scalability issues in the varnish file storage backend. The issue has been successfully mitigated by restarting the varnish backend instance on the mentioned nodes.\n" \
      "\n" \
      "==Timeline==\n" \
      "All times are UTC.\n" \
      "* 05:08 Incident begins. Related graphs: [https://grafana.wikimedia.org/dashboard/file/varnish-aggregate-client-status-codes.json?panelId=2&fullscreen&orgId=1&from=1520830836973&to=1520844409209&var-site=esams&var-cache_type=text&var-status_type=5 Varnish HTTP errors onesams], varnish backend connections ([https://grafana.wikimedia.org/dashboard/db/varnish-machine-stats?panelId=16&fullscreen&orgId=1&from=1520830813292&to=1520844155858&var-server=cp3031&var-datasource=esams%20prometheus%2Fops cp3031], [https://grafana.wikimedia.org/dashboard/db/varnish-machine-stats?panelId=16&fullscreen&orgId=1&from=1520830813292&to=1520844155858&var-server=cp3033&var-datasource=esams%20prometheus%2Fops cp3033], [https://grafana.wikimedia.org/dashboard/db/varnish-machine-stats?panelId=16&fullscreen&orgId=1&from=1520830813292&to=1520844155858&var-server=cp3042&var-datasource=esams%20prometheus%2Fops cp3042])\n" \
      "* [[toolforge:sal/log/AWIZPsfZkkJ8OkTwiOnZ|08:06]] Restart cp3042 varnish backend instance.\n" \
      "* [[toolforge:sal/log/AWIZV1n3kkJ8OkTwiOn9|08:32]] Restart cp3031 and cp3033 varnish backend instances.\n" \
      "* 08:32 Incident mitigated.\n" \
      "\n" \
      "==Conclusions==\n" \
      "''TBW''\n" \
      "==Actionables==\n" \
      "*Continue ongoing related investigations in [[phab:T181315]]\n" \
      "*Set up paging alerting on backend connections piling up (TBD)\n" \
      "*Move backend restarts from weekly to bi-weekly (done in [[gerrit:419090]])\n" \
      '*Long term: Move to ATS as caching solution for cache backends ([[phab:T96853]])'
    it 'extracts actionables from incident' do
      expect(actionables_wikitext(incident_wikitext)).to eq actionables_wikitext
    end
    it 'extracts actionables from incidents' do
      incidents_wikitext = { 'Incident documentation/20180312-Cache-text' => incident_wikitext }
      expect(actionables(incidents, incidents_wikitext)).to eq actionables_wikitexts
    end
    it 'extracts gerrit patches' do
      expect(gerrit_from_wikitext(actionables_wikitext)).to eq ['419090']
    end
    it 'extracts gerrit patches from incidents' do
      expect(incidents_gerrit(incidents, actionables_wikitexts)).to eq incidents_patches
    end
    it 'tasks from wikitext' do
      incidents_tasks = { 'Incident documentation/20180312-Cache-text' => %w[T181315 T96853] }
      expect(actionables_tasks(incidents, actionables_wikitexts)).to eq incidents_tasks
    end
  end
  context 'gerrit' do
    it 'finds repositories from patches' do
      skip 'calls API'
      incidents_repos = { 'Incident documentation/20180312-Cache-text' => ['operations/puppet'] }
      expect(repos_patches(incidents, incidents_patches)).to eq incidents_repos
    end
  end
  context 'phabricator' do
    gerritbot_comment =
      { 'id' => 3_792_163,
        'phid' => 'PHID-XACT-TASK-alqxs7tpvourtxf',
        'type' => 'comment',
        'authorPHID' => 'PHID-USER-idceizaw6elwiwm5xshb',
        'objectPHID' => 'PHID-TASK-bkf7tel6t5kgjabfk4r3',
        'dateCreated' => 1_511_871_264,
        'dateModified' => 1_511_871_264,
        'comments' =>
       [{ 'id' => 971_358,
          'phid' => 'PHID-XCMT-6y56yjgvs7kef676f72q',
          'version' => 1,
          'authorPHID' => 'PHID-USER-idceizaw6elwiwm5xshb',
          'dateCreated' => 1_511_871_264,
          'dateModified' => 1_511_871_264,
          'removed' => false,
          'content' =>
          { 'raw' =>
            "Change 393751 had a related patch set uploaded (by Gilles; owner: Gilles):\n" \
              "[operations/puppet@production] Log more detailed info in Varnish slow request log\n" \
              "\n" \
              "[[https://gerrit.wikimedia.org/r/393751]]\n" } }],
        'fields' => {} }
    gerritbot_comments = [gerritbot_comment]
    incidents_tasks_repos =
      { 'Incident documentation/20180312-Cache-text' =>
        [{ 'T181315' => ['operations/puppet', 'mediawiki/vagrant'] }, { 'T96853' => [] }] }
    it 'finds phabricator tasks in actionables' do
      expect(phabricator_from_wikitext(actionables_wikitext)).to eq %w[T181315 T96853]
    end
    it 'finds gerritbot comments' do
      task_comments =
        { 'result' =>
        { 'data' =>
          [{ 'id' => 4_507_959,
             'phid' => 'PHID-XACT-TASK-y2be6mni5ivq7oy',
             'type' => nil,
             'authorPHID' => 'PHID-USER-sai77mtxmpqnm6pycyvz',
             'objectPHID' => 'PHID-TASK-bkf7tel6t5kgjabfk4r3',
             'dateCreated' => 1_534_446_481,
             'dateModified' => 1_534_446_481,
             'comments' => [],
             'fields' => {} },
           { 'id' => 3_792_164,
             'phid' => 'PHID-XACT-TASK-eej4ofk434dpuer',
             'type' => nil,
             'authorPHID' => 'PHID-USER-idceizaw6elwiwm5xshb',
             'objectPHID' => 'PHID-TASK-bkf7tel6t5kgjabfk4r3',
             'dateCreated' => 1_511_871_265,
             'dateModified' => 1_511_871_265,
             'comments' => [],
             'fields' => {} },
           gerritbot_comment,
           { 'id' => 4_184_335,
             'phid' => 'PHID-XACT-TASK-6n7rlln6ozsug2e',
             'type' => nil,
             'authorPHID' => 'PHID-USER-sai77mtxmpqnm6pycyvz',
             'objectPHID' => 'PHID-TASK-bkf7tel6t5kgjabfk4r3',
             'dateCreated' => 1_525_543_968,
             'dateModified' => 1_525_543_968,
             'comments' => [],
             'fields' => {} }],
          'cursor' => { 'limit' => 100, 'after' => '3788748', 'before' => nil } },
          'error_code' => nil,
          'error_info' => nil }
      expect(gerritbot_comments(task_comments)).to eq gerritbot_comments
    end
    it 'finds repositories in comments' do
      expect(gerrit_repositories(gerritbot_comments)).to eq ['operations/puppet']
    end
    it 'finds repositories connected to a task' do
      pending 'returns [{"T181315"=>[]}]'
      expect(tasks_repos(['T181315'])).to eq [{ 'T181315' => ['operations/puppet', 'mediawiki/vagrant'] }]
    end
    it 'finds repositories connected to tasks' do
      pending 'returns {"Incident documentation/20180312-Cache-text"=>[{"T181315"=>[]}, {"T96853"=>[]}]}'
      incidents_tasks = { 'Incident documentation/20180312-Cache-text' => %w[T181315 T96853] }
      expect(repos_tasks_verbose(incidents, incidents_tasks)).to eq incidents_tasks_repos
    end
    it 'finds repositories connected to an incident' do
      tasks_repos = [{ 'T181315' => ['operations/puppet', 'mediawiki/vagrant'] }, { 'T96853' => [] }]
      expect(incident_repos(tasks_repos)).to eq ['operations/puppet', 'mediawiki/vagrant']
    end
    it 'finds repositories connected to an incident' do
      incidents_repos = { 'Incident documentation/20180312-Cache-text' => ['operations/puppet', 'mediawiki/vagrant'] }
      expect(repos_tasks_summary(incidents, incidents_tasks_repos)).to eq incidents_repos
    end
    it 'returns merged and deduplicated repositories for an incident' do
      repos_patches = ['operations/puppet']
      repos_tasks = ['operations/puppet', 'mediawiki/vagrant']
      repos = ['operations/puppet', 'mediawiki/vagrant']
      expect(repo_patches_tasks(repos_patches, repos_tasks)).to eq repos
    end
  end
  context 'report' do
    it 'returns repositories connected to an incident' do
      repos_from_patches = { 'Incident documentation/20180312-Cache-text' => ['operations/puppet'] }
      repos_from_tasks = { 'Incident documentation/20180312-Cache-text' => ['operations/puppet', 'mediawiki/vagrant'] }
      repos = { 'Incident documentation/20180312-Cache-text' => ['operations/puppet', 'mediawiki/vagrant'] }
      expect(repos_patches_tasks(incidents, repos_from_patches, repos_from_tasks)).to eq repos
    end
    it 'returns repositories connected to an incident as csv' do
      incidents_and_repos = { 'Incident documentation/20180312-Cache-text' => ['operations/puppet', 'mediawiki/vagrant'] }
      incidents_and_repos_csv =
        "Incident documentation/20180312-Cache-text,operations/puppet\n"\
        "Incident documentation/20180312-Cache-text,mediawiki/vagrant\n"
      expect(csv(incidents_and_repos)).to eq incidents_and_repos_csv
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/LineLength
