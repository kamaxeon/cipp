require 'spec_helper'

files = %w( 
  /etc/nginx/.httpasswd
  /etc/nginx/sites-available/sarg.conf
)
context 'Web Server Role' do

  context 'Packages' do
    packages = %w(
      nginx 
      python-passlib
    )
    packages.each do |pkg|
      describe package pkg do
        it { should be_installed }
      end
    end
  end
  context 'Services' do
    services = %w(
      nginx
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
    describe file '/etc/nginx/sites-enabled/default' do
      it { should_not exist }
    end
  end
  
  context 'Permissions' do
    describe file '/etc/nginx/.httpasswd' do 
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'www-data' }
      it { should be_mode 640 }
    end
    describe file '/etc/nginx/sites-available/sarg.conf' do 
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
    end
  end

  context 'Links' do
    describe file '/etc/nginx/sites-enabled/sarg.conf' do
      it { should be_linked_to '/etc/nginx/sites-available/sarg.conf' }
    end
  end

  context 'Contents' do
   describe file '/etc/nginx/sites-available/sarg.conf' do
      it { should contain 'auth_basic_user_file /etc/nginx/.httpasswd;' }
      it { should contain 'root /usr/share/nginx/squid-reports;' }
    end
    describe file '/etc/nginx/.httpasswd' do
      it { should contain 'admin:' }
    end
  end
  context 'Ansible Signature' do
    check_ansible_header '/etc/nginx/sites-available/sarg.conf'
  end
end
