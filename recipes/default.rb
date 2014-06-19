#
# Cookbook Name:: geminabox
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node[:rbenv][:ruby_version] do
  global true
end

node[:rbenv][:gems].each do |gem|
  rbenv_gem gem
end

directory node[:geminabox][:web_directory]

directory node[:geminabox][:data_root]

directory File.join(node[:geminabox][:data_root], node[:geminabox][:data_directory]) do
  action :create
end

template node[:geminabox][:init_script] do
  source 'geminabox.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service "geminabox" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

template File.join(node[:geminabox][:web_directory], node[:unicorn][:config]) do
  source 'unicorn.erb'
  variables({
    :app_path => node[:geminabox][:web_directory]
  })
end

template File.join(node[:geminabox][:web_directory], 'config.ru') do
  source 'config.erb'
  variables({
    :app_path => node[:geminabox][:web_directory],
    :user => node[:unicorn][:user],
    :ruby_version => node[:rbenv][:ruby_version]
  })
  mode '0644'
  notifies :restart, "service[geminabox]"
end

git node[:napa][:workdir] do
  repository node[:napa][:repository]
  revision "master"
  action :sync
end

bash "gem build napa.gemspec" do
  cwd node[:napa][:workdir]
end

bash "gem inabox --host http://localhost:3000"

bash "gem inabox napa-#{node[:napa][:gem_version]}.gem" do
  cwd node[:napa][:workdir]
end
