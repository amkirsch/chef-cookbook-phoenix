require 'spec_helper'

describe 'phoenix::phoenix' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  # Check if nodejs installed successfully
  describe command("node -v") do
    its(:stdout) { should contain /v6.2.0/ }
  end
end
