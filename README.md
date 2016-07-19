Phoenix Cookbook
================

A cookbook that performs a basic installation of the Phoenix Framework along
with any missing dependencies.

## Dependencies:

This cookbook has no direct external dependencies.  It will install and configure
any missing packages and dependencies.  A stable and decently fast Internet
connection is required.

## Platforms:

The following platforms and versions are tested and supported using
[test-kitchen](http://kitchen.ci/)

* CentOS 7.1

The following platform families are supported in the code.

* Red Hat (RHEL)
* Centos
* Fedora

Usage
=====

Using this cookbook is relatively straightforward. It is recommended to create
a project or organization specific [wrapper cookbook](https://www.chef.io/blog/2013/12/03/doing-wrapper-cookbooks-right/) 
and add the desired recipes to the run list of a node, or create a role. Depending on your
environment, you may have multiple roles that use different recipes
from this cookbook. Adjust any attributes as desired. For example, to
create a basic role:

``````
{
    "name": "phoenix",
    "description": "Role to install the Phoenix Framework and its dependencies.",
    "chef_type": "role",
    "json_class": "Chef::Role",
    "default_attributes": {
    },
    "override_attributes": {
    },
    "run_list": [
        "recipe[phoenix::install_nodejs]", // optional for Phoenix
        "recipe[phoenix::install_erlang]",
        "recipe[phoenix::install_elixir]",
        "recipe[phoenix::install_phoenix]"
    ]
}
``````

## Example: chef-client local-mode

If you are using [chef-client](https://docs.chef.io/ctl_chef_client.html) you can follow this
example based on the role above:

Install Latest Chef

``````
curl -L https://www.opscode.com/chef/install.sh | bash

``````

Create a chef-repo (placed in the /root/ directory in this example) with the 
following structure and files:

``````
chef-repo/
|-- cookbooks
|   `-- phoenix
|       |-- attributes
|       |-- recipes
|       |-- spec
|       `-- test
|-- nodes
|   `-- node_phoenix.json
|   
|-- roles
|   `-- role_phoenix.json
`-- client.rb
``````

% cat chef-repo/nodes/node_phoenix.json
``````
{
  "name": "node_phoenix",
  "run_list": [
    "role[role_phoenix]"
  ]
}
``````

% cat chef-repo/roles/role_phoenix.json
``````
{
    "name": "phoenix",
    "description": "Role to install the Phoenix Framework and its dependencies.",
    "chef_type": "role",
    "json_class": "Chef::Role",
    "default_attributes": {
    },
    "override_attributes": {
    },
    "run_list": [
        "recipe[phoenix::install_nodejs]", // optional for Phoenix
        "recipe[phoenix::install_erlang]",
        "recipe[phoenix::install_elixir]",
        "recipe[phoenix::install_phoenix]"
    ]
}
``````

% cat chef-repo/client.rb
``````
cookbook_path   "/root/chef-repo/cookbooks"
role_path '/root/chef-repo/roles'
data_bag_path  '/root/chef-repo/data_bags'
environment_path '/root/chef-repo/environments'
encrypted_data_bag_secret '/etc/chef'
local_mode 'true'
node_name 'node'
node_path '/root/chef-repo/nodes'
log_level :info
``````

Now we can run our node/role using chef-client local mode (chef-zero):

``````
chef-client -z -c client.rb -j nodes/node_phoenix.json
``````

Attributes
==========

This cookbook has attributes for a basic installation of the Phoenix Framework
and dependencies.  It should all be relatively straight-forward to override if
different versions are desired.

Recipes
=======

The recipes included; install\_erlang and install\_elixir are dependencies
required unless it is known that the environment already has these requirements
installed properly. The recipe install\_phoenix uses Elixir to install Hex and
finally Phoenix itself.

install\_nodejs
-----------------

Installs latest stable build, handles its own dependencies and can be run with or without the other recipes.

install\_erlang
-----------------

This recipe compiles the Erlang language from source. Installs its own required
packages.

install\_elixir
-----------------

This recipe compiles the Elixir language from source.  Requires that
the system have Erlang installed.

install\_phoenix
-----------------

Installs Phoenix framework using Hex.  Requires Elixir and Erlang be installed.

Tests
=====

This cookbook in the [source repository](https://github.com/amkirsch/chef-cookbook-phoenix/)
contains chefspec, serverspec tests.

License and Authors
===================

* Author:: Andrew M. Kirschke <andrew.kirschke@gmx.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

