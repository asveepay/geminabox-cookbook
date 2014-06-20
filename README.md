geminabox Cookbook
==================
Sets up geminabox to run a local gem server. Listens on port 3000 within the VM, mapped to port 8080 on localhost.

Requirements
------------
### Setup
* Vagrant
* Test Kitchen
* Chefspec
* Serverspec
* vagrant-berkshelf plugin, version >= 2.0.1

### cookbooks
* apt
* rbenv


Usage
-----
#### geminabox::default
Just include `geminabox` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[geminabox]"
  ]
}
```

License and Authors
-------------------
Authors: Roland Cooper
