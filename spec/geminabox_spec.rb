require 'spec_helper'

describe "geminabox::default" do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes apt' do
    expect(chef_run).to include_recipe('apt')
  end

  it 'includes rbenv::default' do
    expect(chef_run).to include_recipe('rbenv::default')
  end

  it 'includes rbenv::ruby_build' do
    expect(chef_run).to include_recipe('rbenv::ruby_build')
  end

  it 'installs ruby 1.9.3-p484' do
    expect(chef_run).to rbenv_ruby_install('1.9.3-p484').with(global: true)
  end

  it 'installs unicorn' do
    expect(chef_run).to rbenv_gem_install('unicorn')
  end

  it 'installs geminabox' do
    expect(chef_run).to rbenv_gem_install('geminabox')
  end

  it 'creates the web directory for Geminabox config' do
    expect(chef_run).to create_directory('/var/www')
  end

  it 'creates the root data dir for Geminabox' do
    expect(chef_run).to create_directory('/var/data')
  end

  it 'creates the dir for Geminabox gem storage' do
    expect(chef_run).to create_directory('/var/data/geminabox')
  end

  it 'creates the init.d script for Geminabox service' do
    expect(chef_run).to render_file('/etc/init.d/geminabox').with_content(/\/var\/www/)
  end

  it 'creates the config.ru file for Geminabox' do
    expect(chef_run).to render_file('/var/www/config.ru')
  end

  it 'notifies geminabox service to restart' do
    resource = chef_run.template('/var/www/config.ru')
    expect(resource).to notify('service[geminabox]').to(:restart).delayed
  end

  it 'clones the napa gem from github into /tmp/napa' do
    expect(chef_run).to sync_git('/tmp/napa').with(repository: 'https://github.com/bellycard/napa.git', revision: 'master')
  end

  it 'builds the napa gem' do
    expect(chef_run).to run_bash('gem build napa.gemspec').with_cwd('/tmp/napa')
  end

  it 'configures gem inabox' do
    expect(chef_run).to run_bash('gem inabox --host http://localhost:3000')
  end

  it 'uploads napa gem to local geminabox' do
    expect(chef_run).to run_bash('gem inabox napa-0.2.1.gem')
  end

end
