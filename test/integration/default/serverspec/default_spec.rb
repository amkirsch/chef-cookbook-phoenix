require 'spec_helper'

describe 'phoenix::phoenix' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  describe command("erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell") do
    its(:strout) { should contain /"18"/ }
  end
end
