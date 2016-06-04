#
# Cookbook Name:: phoenix
# Recipe:: install_elixir
#

elixir_tar_path    = Chef::Config[:file_cache_path] + '/' + node[:elixir][:source_tar]
elixir_url         = node[:elixir][:source_url]
elixir_src_path    = Chef::Config[:file_cache_path] + '/' + node[:elixir][:source_dir]
elixir_root        = node[:elixir][:root]

execute "Downloading #{node[:elixir][:source_tar]}" do
  command "wget --directory-prefix=#{Chef::Config[:file_cache_path]} #{elixir_url}"
  action  :run
  not_if { ::File.exists?(elixir_tar_path) }
end

execute "Extracting Archive #{node[:elixir][:source_tar]}" do
  cwd     Chef::Config[:file_cache_path]
  command "tar -zxf #{elixir_tar_path} --directory=#{Chef::Config[:file_cache_path]}"
  action  :run
  not_if { ::File.exists?(elixir_src_path) }
end

execute "Make Elixir Source" do
  cwd     elixir_src_path
  command "export PATH=$PATH:#{node[:erlang][:bin]} && make"
  action  :run
  not_if { ::File.exists?(node[:elixir][:bin]) }
end

execute "Move Built Elixir to Install Location" do
  command "cp -r #{elixir_src_path} #{elixir_root}"
  action  :run
  not_if { ::File.exists?(node[:elixir][:bin]) }
end

file '/etc/profile.d/elixir.sh' do
  content "export PATH=$PATH:#{node[:elixir][:bin]}"
  action :create
  mode 0755
end
