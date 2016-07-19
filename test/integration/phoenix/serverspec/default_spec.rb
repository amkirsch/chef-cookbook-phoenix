require 'spec_helper'

describe 'phoenix::phoenix' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  # Check if Erlang installed successfully
  describe command("erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell") do
    its(:stdout) { should contain /"18"/ }
  end

  # Check if Elixir installed successfully
  describe command("elixir -v") do
    its(:stdout) { should contain /Elixir 1.3.0/ }
  end

  # Check if Phoenix generator is working
  describe command("mix phoenix.new") do
    its(:stdout) { should contain /Creates a new Phoenix project/ }
  end

  # Check if nodejs installed successfully
  describe command("node -v") do
    its(:stdout) { should contain /v6.2.0/ }
  end
end
