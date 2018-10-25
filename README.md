# Incident documentation

Tools for gathering data from [Wikimedia incident documentation](https://wikitech.wikimedia.org/wiki/Incident_documentation).

[![Build Status](https://travis-ci.org/zeljkofilipin/incident-documentation.svg?branch=master)](https://travis-ci.org/zeljkofilipin/incident-documentation)
[![Maintainability](https://api.codeclimate.com/v1/badges/c3f54714f5ceda19e72c/maintainability)](https://codeclimate.com/github/zeljkofilipin/incident-documentation/maintainability)

## Usage

Generate a token at https://phabricator.wikimedia.org/settings/user/USERNAME/page/apitokens/.

    bundle exec ruby phabricator_gerrit.rb API_TOKEN PHABRICATOR_TASK

## Example

    $ bundle exec ruby phabricator_gerrit.rb API_TOKEN T184715
    ...
    T184715: ["operations/debs/pybal"]
