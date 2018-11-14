# rubocop:disable Metrics/BlockLength, Metrics/LineLength
require_relative '../lib/api'

RSpec.describe 'api' do
  context 'gerrit' do
    it 'returns almost json for a task' do
      json =
        "[\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~I49f49f22a955b5d60c620917bd42332b9c153b75\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I49f49f22a955b5d60c620917bd42332b9c153b75\",\n" \
        "    \"subject\": \"varnish: restart backends every 7 days\",\n" \
        "    \"status\": \"ABANDONED\",\n" \
        "    \"created\": \"2018-04-09 12:58:04.000000000\",\n" \
        "    \"updated\": \"2018-04-09 13:04:14.000000000\",\n" \
        "    \"insertions\": 3,\n" \
        "    \"deletions\": 3,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 425045,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 1491\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~I6006b345bba41f02b38cfa50cbbfd94928809703\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"topic\": \"varnish-semiweekly-restarts\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I6006b345bba41f02b38cfa50cbbfd94928809703\",\n" \
        "    \"subject\": \"varnish: restart backends every 3.5 days\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2018-03-13 00:54:58.000000000\",\n" \
        "    \"updated\": \"2018-04-09 13:03:45.000000000\",\n" \
        "    \"submitted\": \"2018-03-13 10:57:37.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 727\n" \
        "    },\n" \
        "    \"insertions\": 12,\n" \
        "    \"deletions\": 6,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 419090,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 727\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~I78160fcd530232423cf22a27a6f414cd8d79e1f9\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I78160fcd530232423cf22a27a6f414cd8d79e1f9\",\n" \
        "    \"subject\": \"varnishslowlog: no Resp filter on backends, either\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2018-03-22 12:36:05.000000000\",\n" \
        "    \"updated\": \"2018-03-22 13:31:20.000000000\",\n" \
        "    \"submitted\": \"2018-03-22 13:30:53.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 727\n" \
        "    },\n" \
        "    \"insertions\": 9,\n" \
        "    \"deletions\": 11,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 421275,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 727\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~I236675cfe6581a0747de00c30c30a413972da213\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"topic\": \"T181315\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I236675cfe6581a0747de00c30c30a413972da213\",\n" \
        "    \"subject\": \"prometheus: aggregation rule for varnish_backend_conn\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2018-03-14 12:36:22.000000000\",\n" \
        "    \"updated\": \"2018-03-14 12:46:23.000000000\",\n" \
        "    \"submitted\": \"2018-03-14 12:46:13.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 1491\n" \
        "    },\n" \
        "    \"insertions\": 4,\n" \
        "    \"deletions\": 0,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 419409,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 1491\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~I9b69f04577a6dbef97bedd345a8d07e53a09573c\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I9b69f04577a6dbef97bedd345a8d07e53a09573c\",\n" \
        "    \"subject\": \"varnishslowlog: add Backend-Timing D\\u003d, in seconds\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2018-03-10 19:54:56.000000000\",\n" \
        "    \"updated\": \"2018-03-13 11:14:01.000000000\",\n" \
        "    \"submitted\": \"2018-03-13 11:14:01.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 727\n" \
        "    },\n" \
        "    \"insertions\": 13,\n" \
        "    \"deletions\": 0,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 418603,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 1491\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~I517d4e95696f3767ac4af226b606130ccb657a07\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I517d4e95696f3767ac4af226b606130ccb657a07\",\n" \
        "    \"subject\": \"varnishslowlog: filter on all timestamps\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2018-03-10 13:32:58.000000000\",\n" \
        "    \"updated\": \"2018-03-13 11:14:01.000000000\",\n" \
        "    \"submitted\": \"2018-03-13 11:14:01.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 727\n" \
        "    },\n" \
        "    \"insertions\": 20,\n" \
        "    \"deletions\": 3,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 418580,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 1491\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~I7e97eaf9fc739aef7dad91a0d9949f788f5db4cd\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"topic\": \"varnish-semiweekly-restarts\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I7e97eaf9fc739aef7dad91a0d9949f788f5db4cd\",\n" \
        "    \"subject\": \"cron_splay: add a semiweekly mode of operation\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2018-03-13 00:54:58.000000000\",\n" \
        "    \"updated\": \"2018-03-13 10:45:12.000000000\",\n" \
        "    \"submitted\": \"2018-03-13 10:45:12.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 727\n" \
        "    },\n" \
        "    \"insertions\": 43,\n" \
        "    \"deletions\": 12,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 419089,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 727\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~Ib45e9180e2785262e2fc7622258c11fc65671a14\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"topic\": \"varnish-semiweekly-restarts\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"Ib45e9180e2785262e2fc7622258c11fc65671a14\",\n" \
        "    \"subject\": \"varnish: remove weekly restart cron entries\",\n" \
        "    \"status\": \"ABANDONED\",\n" \
        "    \"created\": \"2018-03-13 00:54:58.000000000\",\n" \
        "    \"updated\": \"2018-03-13 10:28:36.000000000\",\n" \
        "    \"insertions\": 1,\n" \
        "    \"deletions\": 13,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 419091,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 727\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~I70478d39436cddc70a983ab174041b7e631918e8\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I70478d39436cddc70a983ab174041b7e631918e8\",\n" \
        "    \"subject\": \"text-be: use short hfm time for cacheable+cookie case\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2018-03-12 14:26:08.000000000\",\n" \
        "    \"updated\": \"2018-03-12 14:28:02.000000000\",\n" \
        "    \"submitted\": \"2018-03-12 14:28:02.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 727\n" \
        "    },\n" \
        "    \"insertions\": 5,\n" \
        "    \"deletions\": 2,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 418920,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 727\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~I0dfaa6c27bc6c4224e54808aee9d613893553e5c\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I0dfaa6c27bc6c4224e54808aee9d613893553e5c\",\n" \
        "    \"subject\": \"Varnish: swizzle TTLs by 5%\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2018-02-07 14:29:23.000000000\",\n" \
        "    \"updated\": \"2018-02-08 11:01:22.000000000\",\n" \
        "    \"submitted\": \"2018-02-08 11:00:55.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 1491\n" \
        "    },\n" \
        "    \"insertions\": 105,\n" \
        "    \"deletions\": 0,\n" \
        "    \"unresolved_comment_count\": 1,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 408810,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 727\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~I08851a84857783cfacc75768a3c0216633aa9242\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"topic\": \"T181315\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I08851a84857783cfacc75768a3c0216633aa9242\",\n" \
        "    \"subject\": \"Smarter Varnish slow log\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2017-12-19 13:33:31.000000000\",\n" \
        "    \"updated\": \"2018-01-15 10:38:35.000000000\",\n" \
        "    \"submitted\": \"2018-01-15 10:38:35.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 1491\n" \
        "    },\n" \
        "    \"insertions\": 193,\n" \
        "    \"deletions\": 25,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 399176,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 1357\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"mediawiki%2Fvagrant~master~I789c21c9764f6689e7c3cb4111dd1f11092e1249\",\n" \
        "    \"project\": \"mediawiki/vagrant\",\n" \
        "    \"branch\": \"master\",\n" \
        "    \"topic\": \"T181315\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"I789c21c9764f6689e7c3cb4111dd1f11092e1249\",\n" \
        "    \"subject\": \"Smarter Varnish slow log\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2017-12-04 19:46:49.000000000\",\n" \
        "    \"updated\": \"2017-12-19 12:45:25.000000000\",\n" \
        "    \"submitted\": \"2017-12-19 12:43:21.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 75\n" \
        "    },\n" \
        "    \"insertions\": 194,\n" \
        "    \"deletions\": 1,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 395076,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 1357\n" \
        "    }\n" \
        "  },\n" \
        "  {\n" \
        "    \"id\": \"operations%2Fpuppet~production~Ia5ee2a723dc030920cc4931fbcdb782a8c47c578\",\n" \
        "    \"project\": \"operations/puppet\",\n" \
        "    \"branch\": \"production\",\n" \
        "    \"topic\": \"T181315\",\n" \
        "    \"hashtags\": [],\n" \
        "    \"change_id\": \"Ia5ee2a723dc030920cc4931fbcdb782a8c47c578\",\n" \
        "    \"subject\": \"Log more detailed info in Varnish slow request log\",\n" \
        "    \"status\": \"MERGED\",\n" \
        "    \"created\": \"2017-11-28 12:14:22.000000000\",\n" \
        "    \"updated\": \"2017-11-28 14:42:14.000000000\",\n" \
        "    \"submitted\": \"2017-11-28 14:42:14.000000000\",\n" \
        "    \"submitter\": {\n" \
        "      \"_account_id\": 1491\n" \
        "    },\n" \
        "    \"insertions\": 1,\n" \
        "    \"deletions\": 1,\n" \
        "    \"unresolved_comment_count\": 0,\n" \
        "    \"has_review_started\": true,\n" \
        "    \"_number\": 393751,\n" \
        "    \"owner\": {\n" \
        "      \"_account_id\": 1357\n" \
        "    }\n" \
        "  }\n" \
        "]\n"
      response = ")]}'\n#{json}"
      task = 'T181315'
      expect(gerrit_api_query(task)).to eq response
    end
    it 'returns repository for a patch' do
      expect(patch_repository('419090')).to eq 'operations/puppet'
    end
  end
  context 'wikitech' do
    it 'returns hash of incidents' do
      subset = '20180312'
      incidents_response =
        { 'allpages' =>
          [{ 'pageid' => 442_153,
             'ns' => 0,
             'title' => 'Incident documentation/20180312-Cache-text' }] }
      expect(incidents_response(subset)).to eq incidents_response
    end
    it 'returns incident wikitext' do
      incident = 'Incident documentation/20180312-Cache-text'
      wikitext =
        "This is a draft, edit heavily please.\n" \
        "\n" \
        "==Summary==\n" \
        "From 05:08 to 08:32 UTC on Monday, 12 March 2018 the number of user-facing 503 error messages increased due to piling backend connections in several CDN nodes (cp3011,cp3033 and cp3042) on [[Esams cluster|esams]] datacenter.  The root cause of this incident is unknown, but is likely related to known scalability issues in the varnish file storage backend. The issue has been successfully mitigated by restarting the varnish backend instance on the mentioned nodes.\n" \
        "\n" \
        "==Timeline==\n" \
        "All times are UTC.\n" \
        "* 05:08 Incident begins. Related graphs: [https://grafana.wikimedia.org/dashboard/file/varnish-aggregate-client-status-codes.json?panelId=2&fullscreen&orgId=1&from=1520830836973&to=1520844409209&var-site=esams&var-cache_type=text&var-status_type=5 Varnish HTTP errors on esams], varnish backend connections ([https://grafana.wikimedia.org/dashboard/db/varnish-machine-stats?panelId=16&fullscreen&orgId=1&from=1520830813292&to=1520844155858&var-server=cp3031&var-datasource=esams%20prometheus%2Fops cp3031], [https://grafana.wikimedia.org/dashboard/db/varnish-machine-stats?panelId=16&fullscreen&orgId=1&from=1520830813292&to=1520844155858&var-server=cp3033&var-datasource=esams%20prometheus%2Fops cp3033], [https://grafana.wikimedia.org/dashboard/db/varnish-machine-stats?panelId=16&fullscreen&orgId=1&from=1520830813292&to=1520844155858&var-server=cp3042&var-datasource=esams%20prometheus%2Fops cp3042])\n" \
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
      expect(incident_wikitext(incident)).to eq wikitext
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/LineLength
