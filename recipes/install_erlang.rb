#
# Cookbook Name:: phoenix
# Recipe:: install_erlang
#
# Copyright (c) 2016 Andrew M. Kirschke, All Rights Reserved.

#node[:phoenix][:packages] = %w( tar wget make perl gcc m4 ncurses ncurses-devel termcap sed java-1.8.0-openjdk-devel gcc-c++ unixODBC-devel openssl-devel )

#node[:phoenix][:erlang][:source_tar] = "otp_src_18.3.tar.gz"
#node[:phoenix][:erlang][:source_url] = "http://erlang.org/download/otp_src_18.3.tar.gz"
#node[:phoenix][:erlang][:source_dir] = ChefConfig::[:file_cache_path] + "/otp_src_18.3"
#
#node[:phoenix][:elixir][:source_tar] = "v1.2.4.tar.gz"
#node[:phoenix][:elixir][:source_url] = "https://github.com/elixir-lang/elixir/archive/v1.2.4.tar.gz"
#node[:phoenix][:elixir][:source_dir] = ChefConfig::[:file_cache_path] + "elixir-1.2.4"
#
#node[:phoenix][:archive_url] = "https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez"

erlang_tar      = node[:erlang][:source_tar]
erlang_url      = node[:erlang][:source_url]
erlang_src_dir  = node[:erlang][:source_dir]

erlang_user   = 'root'
erlang_group  = 'root'

options       = node[:erlang][:configure_options]

node[:erlang][:packages].each do |pkg|
  package pkg do
    action :upgrade
  end
end

execute "Downloading #{erlang_tar}" do
  cwd   Chef::Config[:file_cache_path]
  command "wget #{erlang_url}"
  action :run
end

#remote_file Chef::Config[:file_cache_path] + erlang_tar do
#  source erlang_url
#  mode '0755'
#  action :create
#end

execute "Extracting #{erlang_tar}" do
  cwd   Chef::Config[:file_cache_path]
  command "tar -zxf #{erlang_tar}"
  action :run
end

execute "Erlang Configure" do
  cwd erlang_src_dir
  command "./configure #{options}"
  action :run
end

execute "Erlang Install" do
  cwd erlang_src_dir
  command <<-EOF
    make
    make install
    EOF
  action :run
end
