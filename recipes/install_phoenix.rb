#
# Cookbook Name:: phoenix
# Recipe:: install_phoenix
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

elixir_bin     = node[:elixir][:bin]

execute "Install Hex for Elixir" do
  command "export PATH=$PATH:#{elixir_bin} && mix local.hex --force"
  action  :run
end

execute "Install Phoenix Framework" do
  command "export PATH=$PATH:#{elixir_bin} && mix archive.install #{node[:phoenix][:archive_url]} --force"
  action  :run
end
