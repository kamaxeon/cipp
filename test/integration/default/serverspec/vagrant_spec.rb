require 'spec_helper'

context 'Vagrant Role' do
  context 'Files' do
    describe file '/etc/environment' do
     it { should be_file }
     it { should be_owned_by 'root' }
     it { should be_grouped_into 'root' }
     it { should be_mode 644 }
     it { should contain 'LC_ALL="en_US.utf8"' }
    end
  end
end
