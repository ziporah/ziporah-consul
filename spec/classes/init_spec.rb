require 'spec_helper'
describe 'consul' do

  let(:facts) { {:osfamily => 'RedHat', :operatingsystemrelease => 'RedHat Linux release 7.0'} }

  context 'with defaults for all parameters' do
    it { should contain_class('consul') }
  end
end
