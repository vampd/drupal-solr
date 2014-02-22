require "spec_helper"

# Write integration tests with Serverspec - http://serverspec.org/
describe "drupal-solr::default" do
  describe port(8080) do
    it { should be_listening }
  end
end
