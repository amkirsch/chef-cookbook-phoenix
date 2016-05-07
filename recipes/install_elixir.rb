#
# Cookbook Name:: phoenix
# Recipe:: install_elixir
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#default[:elixir][:source_tar] = "v1.2.4.tar.gz"
#default[:elixir][:source_url] = "https://github.com/elixir-lang/elixir/archive/v1.2.4.tar.gz"
#default[:elixir][:source_dir] = Chef::Config[:file_cache_path] + "elixir-1.2.4"

elixir_tar          = node[:elixir][:source_tar]
elixir_url          = node[:elixir][:source_url]
elixir_src_dir      = node[:elixir][:source_dir]
elixir_root         = node[:elixir][:root]

execute "Downloading #{elixir_tar}" do
  cwd     Chef::Config[:file_cache_path]
  command "wget #{elixir_url}"
  action  :run
end

execute "Extracting Archive #{elixir_tar}" do
  cwd     Chef::Config[:file_cache_path]
  command "tar -zxf #{elixir_tar}"
  action  :run
end

execute "Make Elixir Source" do
  cwd     Chef::Config[:file_cache_path] + '/' + elixir_src_dir
  command "export PATH=$PATH:/usr/local/bin && make"
  action  :run
end

execute "Move Built Elixir to Install Location" do
  cwd     Chef::Config[:file_cache_path]
  command "mv #{elixir_src_dir} #{elixir_root}"
  action  :run
end
