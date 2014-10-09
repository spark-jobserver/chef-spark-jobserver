require 'chefspec'
require 'chefspec/berkshelf'
require 'spec_helper.rb'

shared_examples 'general tests' do |platform, platform_version|
  context "on #{platform} #{platform_version}" do

    let(:chef_run) do
      ChefSpec::Runner.new(
        platform: platform,
        version: platform_version
      ) do |node|
        node.force_default.spark.jobserver.spark_home = '/usr/local/spark'
        node.force_default.spark.jobserver.spark_conf_dir = '/usr/local/spark/conf'
        node.force_default.spark.jobserver.jar_url = 'http://somewhe.re/jar.jar'
      end
    end

    before do
      stub_command("rpm -qa | grep -q '^runit'").and_return(true)
    end

    it 'runs without errors.' do
      chef_run.converge(described_recipe)
    end

    it 'creates a jobserver service resource and starts it by default' do
      chef_run.converge(described_recipe)

      expect(chef_run).to start_jobserver_runit_service('spark-jobserver')
    end

  end
end

describe 'spark-jobserver::default' do
  platforms = {
    # for whatever reason there's no fauxhai data for 12.10
    'ubuntu' => [ '12.04', '13.04', '13.10', '14.04' ],
    'debian' => [ '6.0.5' ],
    'centos' => [ '5.8', '6.0', '6.3' ],
    'redhat' => [ '5.8', '6.3' ],
  }

  platforms.each do |platform, versions|
    versions.each do |platform_version|
      Fauxhai.mock(platform: platform, version: platform_version)
      include_examples 'general tests', platform, platform_version
    end
  end
end
