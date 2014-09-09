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
  spark_dist_tarball = 'spark-1.0.2-bin-hadoop2.tgz'
  spark_install = 'spark-1.0.2-bin-hadoop2'

  unless File.exists?(spark_install)
    `tar -xvzf #{spark_dist_tarball}`
    `cp #{spark_install}/conf/spark-defaults.conf.template #{spark_install}/conf/spark-defaults.conf`
    `cp #{spark_install}/conf/spark-env.sh.template #{spark_install}/conf/spark-env.sh`
  end

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      spark: {
        jobserver: {
          port: 8090,
          spark_home: "/vagrant/#{spark_install}",
          jar_url: 'file:///vagrant/spark-job-server.jar',
        }
      }
    }

    chef.run_list = [
      'recipe[spark-jobserver::demo_setup]',
      'recipe[spark-jobserver::default]',
    ]

    chef.custom_config_path = 'vagrant-solo.rb'
  end
end
