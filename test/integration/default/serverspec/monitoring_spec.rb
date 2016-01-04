require 'spec_helper'

files = %w( 
  /etc/monit/monitrc
  /etc/monit/conf.d/proxy-server
  /etc/monit/conf.d/smtp-server
  /etc/monit/conf.d/system
  /etc/monit/conf.d/ddclient
)
context 'Monitoring Role' do

  context 'Packages' do
    packages = %w(
      monit
    )
    packages.each do |pkg|
      describe package pkg do
        it { should be_installed }
      end
    end
  end
  context 'Services' do
    services = %w(
      monit
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
    describe file '/etc/monit/monitrc' do 
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 600 }
    end
    conf_d_files = %w(
      /etc/monit/conf.d/proxy-server
      /etc/monit/conf.d/smtp-server
      /etc/monit/conf.d/system
      /etc/monit/conf.d/ddclient
    )
    conf_d_files.each do |file|
      describe file "#{file}" do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
      end
    end
  end


  context 'Contents' do
   describe file '/etc/monit/monitrc' do
      it { should contain 'set alert alerts_group@localhost not on' }
    end
    describe file '/etc/monit/conf.d/ddclient' do
      it { should contain 'check process ddclient with pidfile /var/run/ddclient.pid' }
    end
    describe file '/etc/monit/conf.d/proxy-server' do
      it { should contain 'check process squid3 with pidfile /var/run/squid3.pid' }
      it { should contain 'check process dansguardian with pidfile /var/run/dansguardian.pid' }
    end
    describe file '/etc/monit/conf.d/smtp-server' do
      it { should contain 'check process postfix with pidfile /var/spool/postfix/pid/master.pid' }
    end
    describe file '/etc/monit/conf.d/system' do
      it { should contain 'check process ntpd with pidfile /var/run/ntpd.pid' }
      it { should contain 'check process sshd with pidfile /var/run/sshd.pid' }
    end
  end
  context 'Ansible Signature' do
    files.each do |file|
      check_ansible_header "#{file}"
    end
  end
end
