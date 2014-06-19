require 'serverspec'

include SpecInfra::Helper::Exec
include SpecInfra::Helper::DetectOS

RSpec.configure do |c|
  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end
end

describe file('/etc/init.d/geminabox') do
  it { should be_file }
end

describe file('/var/www/config.ru') do
  it { should be_file }
end

describe file('/var/www/unicorn.rb') do
  it { should be_file }
end

describe process('unicorn') do
  it { should be_running }
end
