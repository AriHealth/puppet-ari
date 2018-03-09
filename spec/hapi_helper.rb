require 'spec_helper'

describe 'nginx' do
  let(:title) { 'nginx' }
  let(:node) { 'test.example.com' }
  let(:facts) { {} } # Facts go here, and if no facts are needed, this can be omitted.

  it { is_expected.to contain_package(‘nginx’).with(ensure: 'present') }

  it { is_expected.to contain_file(‘/var/www/index.html')
    .with(
      :ensure => 'file',
      :require => 'Package[nginx]',
    )
  }

  it { is_expected.to contain_service(‘nginx')
    .with(
      :ensure => 'running',
      :enabled => true,
    )
  }
end