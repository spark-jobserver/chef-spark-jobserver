#
# Cookbook Name:: spark-jobserver
# Recipe:: demo_setup
#
# Copyright (C) 2014 Matt Chu
#
# All rights reserved - Do Not Redistribute
#

# go ahead and use OpenJDK; good enough for a local Vagrant demo
execute 'apt-get update'
package 'openjdk-7-jre'
