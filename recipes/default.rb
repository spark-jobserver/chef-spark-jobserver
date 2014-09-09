#
# Cookbook Name:: spark-jobserver
# Recipe:: default
#
# Copyright (C) 2014 Matt Chu
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'runit::default'

user = node.spark.jobserver.user
group = node.spark.jobserver.group
install_dir = node.spark.jobserver.install_dir
log_dir = node.spark.jobserver.log_dir
env_name = node.spark.jobserver.env_name

directory install_dir do
  owner user
  group user
  recursive true
end

directory node.spark.jobserver.data_dir do
  owner user
  group group
  recursive true
end

remote_file "#{install_dir}/spark-job-server.jar" do
  source node.spark.jobserver.jar_url
end

template "#{install_dir}/#{env_name}.conf" do
  source 'jobserver.conf.erb'
  variables({
    :master_url => node.spark.jobserver.master_url,
    :jobserver_port => node.spark.jobserver.port,

    :jar_dir => node.spark.jobserver.jar_dir,
    :file_dir => node.spark.jobserver.file_dir,

    :standalone_num_cpu => node.spark.jobserver.standalone.num_cpu,

    :default_context_settings => node.spark.jobserver.default_context_settings,
    :default_contexts => node.spark.jobserver.default_contexts,

    :spark_home => node.spark.jobserver.spark_home,
  })
  notifies :reload, 'runit_service[spark-jobserver]', :delayed
end

# must be called log4j-server; hardcoded in server_start.sh
template "#{install_dir}/log4j-server.properties" do
  source 'jobserver.log4j.properties.erb'
  variables({
  })
  notifies :reload, 'runit_service[spark-jobserver]', :delayed
end

template "#{install_dir}/logback-server.xml" do
  source 'jobserver.logback.xml.erb'
  variables({
  })
  notifies :reload, 'runit_service[spark-jobserver]', :delayed
end

# must be called settings.sh
template "#{install_dir}/settings.sh" do
  source 'jobserver.settings.sh.erb'
  variables({
    :install_dir => install_dir,
    :log_dir => log_dir,
    :spark_dir => node.spark.jobserver.spark_home,
    :spark_conf_dir => node.spark.jobserver.spark_conf_dir,
    :mesos_spark_executor_uri => node.spark.jobserver.mesos.spark_executor_uri,
  })
  notifies :reload, 'runit_service[spark-jobserver]', :delayed
end

runit_service 'spark-jobserver' do
  owner user
  group group
  default_logger true
  options({
    :install_dir => install_dir,
    :gc_opts => node.spark.jobserver.gc_opts,
    :java_opts => node.spark.jobserver.java_opts,
  })
  action node.spark.jobserver.service_actions
end
