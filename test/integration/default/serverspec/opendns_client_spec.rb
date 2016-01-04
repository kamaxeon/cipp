require 'spec_helper'

files = %w( 
  /etc/default/ddclient
  /etc/ddclient.conf
)
context 'OpenDNS Role' do

  context 'Packages' do
    packages = %w(
      ddclient 
    )
    packages.each do |pkg|
      describe package pkg do
        it { should be_installed }
      end
    end
  end
  context 'Services' do
    services = %w(
      ddclient
    )
    services.each do |srv|
      describe service srv do
        it { should be_enabled }
        it { should be_running }
      end
    end
  end


  context 'Files' do
    files.each do |file|
      describe file "#{file}" do
        it { should be_file }
      end
    end 
  end
  
  context 'Permissions' do
    files.each do |file|
      describe file "#{file}" do 
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode 600 }
      end
    end
  end

  context 'Contents' do
   describe file '/etc/default/ddclient' do
      it { should contain 'run_ipup="false"' }
      it { should contain 'run_daemon="true"' }
      it { should contain 'daemon_interval="300"' }
    end
    describe file '/etc/ddclient.conf' do
      it { should contain 'daemon=300' }
      it { should contain 'syslog=yes' }
      it { should contain 'mail=alerts_group' }
      it { should contain 'mail-failure=alerts_group' }
      it { should contain 'login=user@test.com' }
      it { should contain 'password=secret' }
      it { should contain 'myhome' }
    end
  end
  context 'Ansible Signature' do
    files.each do |file|
      check_ansible_header "#{file}"
    end
  end
end
