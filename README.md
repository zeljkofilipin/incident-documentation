# Incident documentation

Tools for gathering data from [Wikimedia incident documentation](https://wikitech.wikimedia.org/wiki/Incident_documentation).

[![Build Status](https://travis-ci.org/zeljkofilipin/incident-documentation.svg?branch=master)](https://travis-ci.org/zeljkofilipin/incident-documentation)
[![Maintainability](https://api.codeclimate.com/v1/badges/c3f54714f5ceda19e72c/maintainability)](https://codeclimate.com/github/zeljkofilipin/incident-documentation/maintainability)

## Usage

Generate a token at `https://phabricator.wikimedia.org/settings/user/USERNAME/page/apitokens/`.

    bundle exec ruby incident_documentation.rb API_TOKEN INCIDENTS_SUBSET

## Example

    $ bundle exec ruby incident_documentation.rb API_TOKEN 20180226

    ["Incident documentation/20180226-WikibaseQualityConstraints"]

    {"Incident documentation/20180226-WikibaseQualityConstraints"=>
      "== Summary ==\n" +
    ...
    "[[Category:Incident documentation]]"}

    {"Incident documentation/20180226-WikibaseQualityConstraints"=>
    " ==\n" +
    ...
    "[[Category:Incident documentation]]"}

