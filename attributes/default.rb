## Cookbook Name:: drupal-solr
## Attribute:: solr

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