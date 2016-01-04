require 'serverspec'

set :backend, :exec

RSpec.configure do |c|  
  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end
end

def check_ansible_header (f)
  describe file f do
   a = it { should contain "# This file is autogenerate by ansible\n# Do not edit, changes will be overwritten" }
  end
end  
