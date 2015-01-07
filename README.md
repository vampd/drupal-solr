# drupal-solr

Copies Apache Solr configuration files from a Drupal installation into a solr installation on the server.  Often used to place schema.xml, solrconfig.xml, protwords.txt, and other solr configuration files from the [search_api_solr](https://www.drupal.org/project/search_api_solr) or [apachesolr](https://www.drupal.org/project/apachesolr) Drupal modules into the correct locations on the server.

Commonly used in the [Vampd](https://github.com/vampd/vampd) development environment in conjunction with [chef-solr](https://github.com/dwradcliffe/chef-solr).

## Requirements

This cookbook assumes you already have Apache Solr installed and running on the server and is only concerned with the finishing touches of migrating configuration files into place.  The chef-solr cookbook can be utilized to install and start the Apache Solr service.

This cookbook has been tested on Ubuntu Server 12.04.

## Recipes

- `default` - Copies solr configuration files into specified locations and restarts the solr service.

## Attributes

- `node['drupal_solr']['copy_config_files']` - An array of configuration files to copy, each in the format "source": "destination"

## Authors and License

Authors: Alex Knoll (arknoll@gmail.com), Chris Caldwell (chrisolof@gmail.com)

Copyright 2014, Alex Knoll, Chris Caldwell

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
