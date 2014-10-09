# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.hostname = 'spark-jobserver-berkshelf'
  config.vm.box = 'ubuntu/trusty32'
  config.vm.network :private_network, ip: '33.33.33.123'

  # plugins

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  # provisioning

  # quick-and-dirty spark installation
  spark_install_dir = ENV['SPARK_DIST'] || 'spark-1.1.0-bin-hadoop2.4'
  spark_dist_tarball = "#{spark_install_dir}.tgz"

  unless File.exists?(spark_install_dir)
    `tar -xvzf #{spark_dist_tarball}`
    `cp #{spark_install_dir}/conf/spark-defaults.conf.template #{spark_install_dir}/conf/spark-defaults.conf`
    `cp #{spark_install_dir}/conf/spark-env.sh.template #{spark_install_dir}/conf/spark-env.sh`
  end

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      spark: {
        jobserver: {
          spark_home: "/vagrant/#{spark_install_dir}",
          spark_conf_dir: "/vagrant/#{spark_install_dir}/conf",
          jar_url: 'file:///vagrant/spark-job-server.jar',
        }
      }
    }

    chef.run_list = [
      # demo_setup must come first
      'recipe[spark-jobserver::demo_setup]',
      'recipe[spark-jobserver::default]',
    ]

    chef.custom_config_path = 'vagrant-solo.rb'
  end
end
