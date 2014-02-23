require "spec_helper"

# Write integration tests with Serverspec - http://serverspec.org/
describe port(8080) do
  it { should be_listening }
end
