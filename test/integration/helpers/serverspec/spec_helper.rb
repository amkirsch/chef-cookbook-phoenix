require 'serverspec'

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, family: 'windows'
end

set :path, '/usr/local/bin:/opt/elixir/bin:/opt/nodejs/bin:$PATH'
