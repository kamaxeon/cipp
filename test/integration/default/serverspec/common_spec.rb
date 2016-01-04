require 'spec_helper'

context 'Common Role' do
  context 'Services' do
    describe service 'ntp' do
     it { should be_enabled }
     it { should be_running }
    end
  end

  context 'Ports' do
    describe port 123 do
      it { should be_listening.with 'udp' }
      #it { should_not be_listening.with 'udp6' }
    end
  end
end
