default[:rbenv][:ruby_version] = '1.9.3-p484'
default[:rbenv][:gems] = %w[geminabox unicorn]

default[:geminabox][:web_directory] = '/var/www'
default[:geminabox][:data_root] = '/var/data'
default[:geminabox][:data_directory] = 'geminabox'
default[:geminabox][:init_script] = '/etc/init.d/geminabox'

default[:napa][:repository] = 'https://github.com/bellycard/napa.git'
default[:napa][:gem_version] = '0.2.1'
default[:napa][:workdir] = '/tmp/napa'

default[:unicorn][:user] = 'root'
default[:unicorn][:config] = 'unicorn.rb'

