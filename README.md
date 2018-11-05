# Incident documentation

Tools for gathering data from [Wikimedia incident documentation](https://wikitech.wikimedia.org/wiki/Incident_documentation).

[![Build Status](https://travis-ci.org/zeljkofilipin/incident-documentation.svg?branch=master)](https://travis-ci.org/zeljkofilipin/incident-documentation)
[![Maintainability](https://api.codeclimate.com/v1/badges/c3f54714f5ceda19e72c/maintainability)](https://codeclimate.com/github/zeljkofilipin/incident-documentation/maintainability)

## Usage

Generate a token at `https://phabricator.wikimedia.org/settings/user/USERNAME/page/apitokens/`.

    bundle exec ruby incident_documentation.rb API_TOKEN INCIDENTS_SUBSET

## Example

     $ bundle exec ruby incident_documentation.rb API_TOKEN 20180312

     Incidents that start with 20180312
     ["Incident documentation/20180312-Cache-text"]

     Gerrit patches in Actionables section
     {"Incident documentation/20180312-Cache-text"=>["419090"]}

     Gerrit repositories from Gerrit patches
     {"Incident documentation/20180312-Cache-text"=>["operations/puppet"]}

     Phabricator tasks in Actionables section
     {"Incident documentation/20180312-Cache-text"=>["T181315", "T96853"]}

     Gerrit repositories from Phabricator tasks verbose
     {"Incident documentation/20180312-Cache-text"=>
       [{"T181315"=>["operations/puppet", "mediawiki/vagrant"]}, {"T96853"=>[]}]}

     Gerrit repositories from Phabricator tasks summary
     {"Incident documentation/20180312-Cache-text"=>
       ["operations/puppet", "mediawiki/vagrant"]}
