#
# Cookbook Name:: drupal-solr
# Recipe:: default
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
#

include_recipe "tomcat"
include_recipe "curl"

solr_archive = "solr-" + node['drupal_solr']['version']

solr_version = node['drupal_solr']['version'][0,1] + ".x"

# solr home directory

solr_home = "#{node['drupal_solr']['home_dir']}/collection1/conf"

directory solr_home do
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode 0775
  recursive true
end

directory node['drupal_solr']['home_dir'] do
  owner node['tomcat']['user']
  group node['tomcat']['group']
end

directory "#{node['drupal_solr']['home_dir']}/collection1" do
  owner node['tomcat']['user']
  group node['tomcat']['group']
end

#solr.war directory
directory node['drupal_solr']['war_dir'] do
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode 0775
  recursive true
end

remote_file "#{node['drupal_solr']['war_dir']}/solr-#{node['drupal_solr']['version']}.tgz" do
  source node['drupal_solr']['url']
  action :create_if_missing
end

bash "extract-solr-#{node['drupal_solr']['version']}" do
  cwd node['drupal_solr']['war_dir']
  code <<-EOH
    tar xvfz #{node['drupal_solr']['war_dir']}/solr-#{node['drupal_solr']['version']}.tgz
    cp #{solr_archive}/example/webapps/solr.war .
  EOH
  creates node['drupal_solr']['war_dir'] + "/solr.war"
  notifies :restart, "service[tomcat]", :delayed
end

solr_context_file = node['tomcat']['context_dir'] + "/" +
                    node['drupal_solr']['app_name'] + ".xml"

template solr_context_file do
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode 0644
  source "solr_context.xml.erb"
  notifies :restart, "service[tomcat]"
end

# Get the Chef::CookbookVersion for this cookbook
cb = run_context.cookbook_collection[cookbook_name]

# Loop over the array of files
cb.manifest['files'].each do |cbf|
  # cbf['path'] is relative to the cookbook root, eg
  #   'files/default/foo.txt'
  # cbf['name'] strips the first two directories, eg
  #   'foo.txt'

  if cbf['path'].include? "solr-conf/#{solr_version}"

    filename = File.basename(cbf['name'])

    cookbook_file "#{solr_home}/#{filename}" do
      source cbf['name']
      owner node['tomcat']['user']
      group node['tomcat']['group']
      mode 0644
      action :create_if_missing
    end
  end
end
