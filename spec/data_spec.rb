# rubocop:disable Metrics/BlockLength, Metrics/LineLength
require_relative '../lib/data'

RSpec.describe 'incident report' do
  context 'wikitext' do
    actionables_wikitext =
      "==\n" \
      "*Continue ongoing related investigations in [[phab:T181315]]\n" \
      "*Set up paging alerting on backend connections piling up (TBD)\n" \
      "*Move backend restarts from weekly to bi-weekly (done in [[gerrit:419090]])\n" \
      '*Long term: Move to ATS as caching solution for cache backends ([[phab:T96853]])'
    actionables_wikitexts = { 'Incident documentation/20180312-Cache-text' => actionables_wikitext }
    incidents = ['Incident documentation/20180312-Cache-text']
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
    it 'extracts gerrit patches from wikitext' do
      expect(gerrit_from_wikitext(actionables_wikitext)).to eq ['419090']
    end
    it 'extracts gerrit patches from incidents' do
      incidents_patches = { 'Incident documentation/20180312-Cache-text' => ['419090'] }
      expect(incidents_gerrit(incidents, actionables_wikitexts)).to eq incidents_patches
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/LineLength
