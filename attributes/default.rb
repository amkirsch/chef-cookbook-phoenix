case node['platform']
when 'redhat', 'centos', 'fedora'
  default[:erlang][:packages] = %w{ tar wget make perl gcc m4 ncurses ncurses-devel sed java-1.8.0-openjdk-devel gcc-c++ unixODBC-devel openssl-devel }

  default[:erlang][:source_tar] = "otp_src_18.3.tar.gz"
  default[:erlang][:source_url] = "http://erlang.org/download/otp_src_18.3.tar.gz"
  default[:erlang][:source_dir] = "otp_src_18.3"
  default[:erlang][:root]       = "/usr/local/lib/erlang"
  default[:erlang][:bin]        = node[:erlang][:root] + "/bin"
  default[:erlang][:configure_options] = ""

  default[:elixir][:source_tar] = "v1.3.0.tar.gz"
  default[:elixir][:source_url] = "https://github.com/elixir-lang/elixir/archive/v1.3.0.tar.gz"
  default[:elixir][:source_dir] = "elixir-1.3.0"
  default[:elixir][:root]       = "/opt/elixir"
  default[:elixir][:bin]        = node[:elixir][:root] + "/bin"

  default[:phoenix][:archive_url] = "https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez"

  default[:nodejs][:packages]             = ['wget']
  default[:nodejs][:binary_url]           = "https://nodejs.org/dist/v6.2.0/node-v6.2.0-linux-x64.tar.xz"
  default[:nodejs][:binary_tar]           = "node-v6.2.0-linux-x64.tar.xz"
  default[:nodejs][:binary_extracted_tar] = "node-v6.2.0-linux-x64"
  default[:nodejs][:binary_dir]           = "nodejs"
  default[:nodejs][:root]                 = "/opt/nodejs"
  default[:nodejs][:install_root]         = "/opt/"
  default[:nodejs][:bin]                  = node[:nodejs][:root] + "/bin"
end

