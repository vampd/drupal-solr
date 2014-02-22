#
# Cookbook Name:: drupal-solr
# Attributes:: default
#
# Copyright (C) 2014 Alex Knoll <arknoll@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# must be one of the versions available at http://archive.apache.org/dist/lucene/solr/
# must be consistent with node['drupal_solr']['apachesolr_conf_dir']
default['drupal_solr']['version']   = '4.2.1'
default['drupal_solr']['url']       = "http://archive.apache.org/dist/lucene/solr/" +
                                       node['drupal_solr']['version'] + "/solr-" +
                                       node['drupal_solr']['version']+ ".tgz"

default['drupal_solr']['app_name']  = "solr"
default['drupal_solr']['war_dir']   = "/opt/solr"
default['drupal_solr']['home_dir']  = "/opt/solr/#{node['drupal_solr']['app_name']}"

default['drupal_solr']['php_client_url'] =
  "https://solr-php-client.googlecode.com/files/SolrPhpClient.r22.2009-11-09.tgz"

default['tomcat']['keytool'] = "/usr/lib/jvm/java-6-openjdk-amd64/bin/keytool"
