require 'spec_helper'

context 'Smtp Server Role' do

  dir = '/etc/postfix'
  context 'Packages' do
    packages = %w(
      postfix
      mailutils
      libsasl2-2
      ca-certificates
      libsasl2-modules 
    )
    packages.each do |pkg|
      describe package pkg do
        it { should be_installed }
      end
    end
  end
  context 'Services' do
    describe service 'postfix' do
      it { should be_enabled }
      it { should be_running }
    end
  end

  context 'Ports' do
    describe port 25 do
      it { should be_listening.on('127.0.0.1').with('tcp') }
    end
  end

  context 'Files' do
    files = %w( 
      cacert.pem
      main.cf
      sasl_passwd
      sasl_passwd.db
      aliases
      aliases.db
    )
    files.each do |file|
      describe file "#{dir}/#{file}" do
        it { should be_file }
      end
    end 
  end
  
  context 'Certificates' do
    describe x509_certificate "#{dir}/cacert.pem" do
      it { should be_certificate }
      it { should be_valid }
    end
  end

  context 'Permissions' do
    describe file "#{dir}/cacert.pem" do 
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
    end
    describe file "#{dir}/main.cf" do 
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
    end
    describe file "#{dir}/sasl_passwd" do 
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'postfix' }
      it { should be_mode 640 }
    end
    describe file "#{dir}/sasl_passwd.db" do 
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'postfix' }
      it { should be_mode 640 }
    end
    describe file "#{dir}/aliases" do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
    end
    describe file "#{dir}/aliases.db" do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
    end
  end
  context 'Contents' do
    describe file "#{dir}/main.cf" do
      it { should contain 'alias_database = hash:/etc/aliases, hash:/etc/postfix/aliases' }
    end
    describe file "#{dir}/aliases" do
      it { should contain 'alerts_group: somebody@test.com' }
    end
    describe file "#{dir}/sasl_passwd" do
      it { should contain '[smtp.test.com]:25  user@test.com:secret' }
    end
  end
end
