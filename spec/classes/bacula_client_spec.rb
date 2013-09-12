require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'bacula::client' do

  let(:title) { 'bacula::client' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test standard Centos installation' do
    let(:facts) { { :operatingsystem => 'Centos' } }
    it { should contain_package('bacula-client').with_ensure('present') }
    it { should contain_file('bacula_fd.conf').with_ensure('present') }
    it { should contain_service('bacula-fd').with_ensure('running') }
    it { should contain_service('bacula-fd').with_enable('true') }
  end

  describe 'Test standard Debian installation' do
    let(:facts) { { :operatingsystem => 'Debian' } }
    it { should contain_package('bacula-fd').with_ensure('present') }
    it { should contain_file('bacula_fd.conf').with_ensure('present') }
    it { should contain_file('bacula_fd.conf').with_path('/etc/bacula/bacula-fd.conf') }
    it { should contain_file('bacula_fd.conf').without_content }
    it { should contain_file('bacula_fd.conf').without_source }
    it { should contain_service('bacula-fd').with_ensure('running') }
    it { should contain_service('bacula-fd').with_enable('true') }
  end

  describe 'Test customizations - provide source' do
    let(:facts) do
      {
        :bacula_client_source  => 'puppet:///modules/bacula/bacula.source'
      }
    end
    it { should contain_file('bacula_fd.conf').with_path('/etc/bacula/bacula-fd.conf') }
    it { should contain_file('bacula_fd.conf').with_source('puppet:///modules/bacula/bacula.source') }
  end

  describe 'Test customizations - provided template' do
    let(:facts) do
      {
        :bacula_client_address => '10.42.42.42',
        :bacula_client_template => 'bacula/bacula-fd.conf.erb'
      }
    end
    let(:expected) do
"# This file is managed by Puppet. DO NOT EDIT.

# Directors who are permitted to contact this File daemon.
Director {
  Name = rspec.example42.com
  Password = \"\"
}

# Restricted Director, used by tray-monitor for File daemon status.
Director {
  Name = rspec.example42.com
  Password = \"\"
  Monitor = Yes
}

# \"Global\" File daemon configuration specifications.
FileDaemon {
  Name = rspec.example42.com
  FDport = 9102
  WorkingDirectory = /var/spool/bacula
  PidDirectory = /var/run
  MaximumConcurrentJobs = 10
  FDAddress = 10.42.42.42
  Heartbeat Interval = 1 minute
}

# Send all messages except skipped files back to Director.
Messages {
  Name = Standard
  Director = rspec.example42.com = all, !skipped, !restored
}
"
    end
    it { should contain_file('bacula_fd.conf').with_content(expected) }
  end

  describe 'Test customizations - custom template' do
    let(:facts) do
      {
        :bacula_client_template => 'bacula/spec.erb',
        :options => { 'opt_a' => 'value_a' }
      }
    end
    it { should contain_file('bacula_fd.conf').with_content(/fqdn: rspec.example42.com/) }
    it { should contain_file('bacula_fd.conf').without_source }
    it { should contain_file('bacula_fd.conf').with_content(/value_a/) }

    it 'should generate a valid template' do
      content = catalogue.resource('file', 'bacula_fd.conf').send(:parameters)[:content]
      content.should match "fqdn: rspec.example42.com"
    end
    it 'should generate a template that uses custom options' do
      content = catalogue.resource('file', 'bacula_fd.conf').send(:parameters)[:content]
      content.should match "value_a"
    end
  end



  describe 'Test standard installation with monitoring and firewalling' do
    let(:facts) do 
      { 
        :monitor        => 'true',
        :firewall       => 'true',
        :client_service => 'bacula-fd',
        :protocol       => 'tcp',
        :client_port    => '9102',
        :concat_basedir => '/var/lib/puppet/concat',
      }
    end
    it { should contain_package('bacula-client').with_ensure('present') }
    it { should contain_service('bacula-fd').with_ensure('running') }
    it { should contain_service('bacula-fd').with_enable(true) }
    it { should contain_file('bacula_fd.conf').with_ensure('present') }
    it { should contain_monitor__process('bacula_client_process').with_enable(true) }
    it { should contain_monitor__port('monitor_bacula_client_tcp_9102').with_enable(true) }
    it { should contain_firewall('firewall_bacula_client_tcp_9102').with_enable(true) }
  end

  describe 'Test Centos decommissioning - absent' do
    let(:facts) { {:bacula_absent => true, :operatingsystem => 'Centos', :monitor => true} }
    it 'should remove Package[bacula-client]' do should contain_package('bacula-client').with_ensure('absent') end
    it 'should stop Service[bacula-fd]' do should contain_service('bacula-fd').with_ensure('stopped') end
    it 'should not enable at boot Service[bacula-fd]' do should contain_service('bacula-fd').with_enable('false') end
  end

  describe 'Test Debian decommissioning - absent' do
    let(:facts) { {:bacula_absent => true, :operatingsystem => 'Debian', :monitor => true} }
    it 'should remove Package[bacula-fd]' do should contain_package('bacula-fd').with_ensure('absent') end
    it 'should stop Service[bacula-fd]' do should contain_service('bacula-fd').with_ensure('stopped') end
    it 'should not enable at boot Service[bacula-fd]' do should contain_service('bacula-fd').with_enable('false') end
  end

  describe 'Test decommissioning - disable' do
    let(:facts) { {:bacula_disable => true, :monitor => true} }
    it { should contain_package('bacula-client').with_ensure('present') }
    it 'should stop Service[bacula-fd]' do should contain_service('bacula-fd').with_ensure('stopped') end
    it 'should not enable at boot Service[bacula-fd]' do should contain_service('bacula-fd').with_enable('false') end
  end

  describe 'Test decommissioning - disableboot' do
    let(:facts) { {:bacula_disableboot => true, :monitor => true } }
    it { should contain_package('bacula-client').with_ensure('present') }
    it { should_not contain_service('bacula-fd').with_ensure('present') }
    it { should_not contain_service('bacula-fd').with_ensure('absent') }
    it 'should not enable at boot Service[bacula-fd]' do should contain_service('bacula-fd').with_enable('false') end
  end

  describe 'Test noops mode' do
    let(:facts) { {:bacula_noops => true, :monitor => true} }
    it { should contain_package('bacula-client').with_noop('true') }
    it { should contain_service('bacula-fd').with_noop('true') }
  end
end 