require_relative 'spec_helper'

describe 'rackspace_apache_php_test::default on Centos 6.5' do
  before do
    stub_resources
  end

  CENTOS65_SERVICE_OPTS = {
    log_level: LOG_LEVEL,
    platform: 'centos',
    version: '6.5'
  }

  cached(:chef_run) do
    ChefSpec::SoloRunner.new(CENTOS65_SERVICE_OPTS) do |node|
      node_resources(node)
    end.converge('rackspace_apache_php_test::default')
  end

  context 'Apache 2.2' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(CENTOS65_SERVICE_OPTS) do |node|
        node.set['apache']['version'] = '2.2'
      end.converge('rackspace_apache_php_test::default')
    end
    it_behaves_like 'Apache2'
    it_behaves_like 'Apache2 PHP handler', 'centos', '2.2'
    it_behaves_like 'PHP-FPM'
    it_behaves_like 'Yum IUS repo'
  end
  context 'Apache 2.4' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(CENTOS65_SERVICE_OPTS) do |node|
        node.set['apache']['version'] = '2.4'
      end.converge('rackspace_apache_php_test::default')
    end
    it_behaves_like 'Apache2'
    it_behaves_like 'Apache2 PHP handler', 'centos', '2.4'
    it_behaves_like 'PHP-FPM'
    it_behaves_like 'Yum IUS repo'
  end
end
