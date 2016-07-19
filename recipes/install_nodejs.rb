#
# Cookbook Name:: phoenix
# Recipe:: install_nodejs
#

nodejs_tar_path            = Chef::Config[:file_cache_path] + '/' + node[:nodejs][:binary_tar]
nodejs_extracted_tar_path  = Chef::Config[:file_cache_path] + '/' + node[:nodejs][:binary_extracted_tar]
nodejs_binary_path         = Chef::Config[:file_cache_path] + '/' + node[:nodejs][:binary_dir]
nodejs_url                 = node[:nodejs][:binary_url]
nodejs_install_root        = node[:nodejs][:install_root]
nodejs_root                = node[:nodejs][:root]

node[:nodejs][:packages].each do |pkg|
  package pkg do
    action :upgrade
  end
end

execute "Downloading #{node[:nodejs][:binary_tar]}" do
  command "wget --directory-prefix=#{Chef::Config[:file_cache_path]} #{nodejs_url}"
  action  :run
  not_if { ::File.exists?(nodejs_tar_path) }
end

execute "Extracting Archive #{node[:nodejs][:binary_tar]}" do
  cwd     Chef::Config[:file_cache_path]
  command "tar -xf #{nodejs_tar_path} --directory=#{Chef::Config[:file_cache_path]}"
  action  :run
  #not_if { ::File.exists?(nodejs_extracted_tar_path) }
end

execute "Rename extracted content to nodejs" do
  command "mv #{nodejs_extracted_tar_path} #{nodejs_binary_path}"
  action  :run
  not_if { ::File.exists?(nodejs_binary_path) }
end

execute "Move nodejs to Install Location" do
  command "cp -r #{nodejs_binary_path} #{nodejs_install_root}"
  action  :run
  not_if { ::File.exists?(node[:nodejs][:root]) }
end

file '/etc/profile.d/nodejs.sh' do
  content "export PATH=$PATH:#{node[:nodejs][:bin]}"
  action :create
  mode 0755
end
