#
# Cookbook Name:: phoenix
# Recipe:: install_erlang
#

erlang_tar_path      = Chef::Config[:file_cache_path] + '/' + node[:erlang][:source_tar]
erlang_url           = node[:erlang][:source_url]
erlang_src_path      = Chef::Config[:file_cache_path] + '/' + node[:erlang][:source_dir]
erlang_root          = node[:erlang][:root]
erlang_bin           = node[:erlang][:bin]

options              = node[:erlang][:configure_options]

node[:erlang][:packages].each do |pkg|
  package pkg do
    action :upgrade
  end
end

execute "Downloading #{node[:erlang][:source_tar]}" do
  command "wget --directory-prefix=#{Chef::Config[:file_cache_path]} #{erlang_url}"
  action  :run
  not_if { ::File.exists?(erlang_tar_path) }
end

#remote_file Chef::Config[:file_cache_path] + erlang_tar_path do
#  source erlang_url
#  mode '0755'
#  action :create
#end

execute "Extracting #{node[:erlang][:source_tar]}" do
  command "tar -zxf #{erlang_tar_path} --directory=#{Chef::Config[:file_cache_path]}"
  action  :run
  not_if { ::File.exists?(erlang_src_path) }
end

execute "Erlang Configure" do
  cwd erlang_src_path
  command "./configure #{options}"
  action  :run
  not_if { ::File.exists?(erlang_root) }
end

execute "Erlang Install" do
  cwd erlang_src_path
  command <<-EOF
    make
    make install
    EOF
  action :run
  not_if { ::File.exists?(erlang_root) }
end

file '/etc/profile.d/erlang.sh' do
  content "export PATH=$PATH:#{node[:erlang][:bin]}"
  action :create
  mode 0755
end
