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

## Vampd Example

This example sets up a basic solr 3.5.0 instance configured for the [apachesolr](https://www.drupal.org/project/apachesolr) Drupal module.

Make sure these two lines are in your Vampd Berksfile:

    cookbook 'solr', '~> 0.3.0'
    cookbook "drupal-solr", git: "https://github.com/vampd/drupal-solr", tag: "2.0.0"

Make sure solr and drupal-solr are in your run list (chef/roles/base.json within your Vampd directory) AFTER the "recipe[drupal]", line:

    "recipe[solr]",
    "recipe[drupal-solr]",

Configure your development environment to include a configured solr server instance (chef/environments/development.json within your Vampd directory).  You'll need to add a comma after the bracket that ends the PHP section near the end of that json file, then add the following sections:

    "solr": {
      "version": "3.5.0",
      "url": "http://archive.apache.org/dist/lucene/solr/3.5.0/apache-solr-3.5.0.tgz",
      "port": "8983",
      "data_dir": "/opt/solr-3.5.0/example/solr"
    },
    "drupal_solr": {
      "copy_config_files": {
        "/srv/www/[site_name]/current/sites/all/modules/contrib/apachesolr/solr-conf/solr-3.x/solrconfig.xml": "/opt/solr-3.5.0/example/solr/conf/",
        "/srv/www/[site_name]/current/sites/all/modules/contrib/apachesolr/solr-conf/solr-3.x/protwords.txt": "/opt/solr-3.5.0/example/solr/conf/",
        "/srv/www/[site_name]/current/sites/all/modules/contrib/apachesolr/solr-conf/solr-3.x/schema.xml": "/opt/solr-3.5.0/example/solr/conf/"
      }
    }

Notice that how you configure the solr instance is completey up to you - see the [chef-solr](https://github.com/dwradcliffe/chef-solr) repo for more information on that front.

Also notice that we're copying the three solr configuration files from the [apachesolr](https://www.drupal.org/project/apachesolr) Drupal module from within a specific site ([site_name] in this case) on this Vampd development machine into the correct spots into our solr instance's configuration directory.  This is a typical final step in configuring your Solr instance to work with either of the [search_api_solr](https://www.drupal.org/project/search_api_solr) or [apachesolr](https://www.drupal.org/project/apachesolr) Drupal modules.  Please refer to your specific solr module's installation instructions for a listing of the exact files you'll need to copy over.
