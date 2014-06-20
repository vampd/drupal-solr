name             'drupal-solr'
maintainer       "Alex Knoll"
license          'Apache 2.0'
description      'Adds configured solr instance'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends 'curl'
depends 'tomcat'
depends 'java'
