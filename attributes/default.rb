case node['platform']
when 'redhat', 'centos', 'fedora'
  default[:erlang][:packages] = %w{ tar wget make perl gcc m4 ncurses ncurses-devel sed java-1.8.0-openjdk-devel gcc-c++ unixODBC-devel openssl-devel }

  default[:erlang][:source_tar] = "otp_src_18.3.tar.gz"
  default[:erlang][:source_url] = "http://erlang.org/download/otp_src_18.3.tar.gz"
  default[:erlang][:source_dir] = Chef::Config[:file_cache_path] + "/otp_src_18.3"
  default[:erlang][:configure_options] = ""

  default[:elixir][:source_tar] = "v1.2.4.tar.gz"
  default[:elixir][:source_url] = "https://github.com/elixir-lang/elixir/archive/v1.2.4.tar.gz"
  default[:elixir][:source_dir] = Chef::Config[:file_cache_path] + "elixir-1.2.4"

  default[:phoenix][:archive_url] = "https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez"
end
