#
# Cookbook Name:: drupal-solr
# Recipe:: default
#
# Copyright (C) 2014 Alex Knoll <arknoll@gmail.com>, Chris Caldwell
# <chrisolof@gmail.com>
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

# If any solr configuration files are defined for copying, copy them over.
if node[':drupal_solr'][:copy_config_files].any?
  node[':drupal_solr'][:copy_config_files].each do |source, destination|
    bash "Copy solr configuration file from #{source} to #{destination}" do
      cwd "/"
      user 'root'
      cmd = "cp #{source} #{destination}"
      code <<-EOH
        set -x
        set -e
        #{cmd}
      EOH
    end
  end
end
