# spark-jobserver cookbook

Installs the [Spark Jobserver](../spark-jobserver/spark-jobserver).

Dev quickstart:

```ruby
# minimal required configuration; these values have no defaults and must be provided
chef.json = {
  spark: {
    jobserver: {
      # path to your spark install
      spark_home: '/usr/local/spark',
      spark_conf_dir: '/usr/local/spark/conf',
      # you need to provide the jobserver jar; this gets downloaded, but can be a `file://` uri
      jar_url: 'https://domain.com/some/path/spark-job-server.jar'
    }
  }
}

include_recipe 'spark-jobserver::default'
```

To use the provided [Vagrantfile](Vagrantfile) to spin up a demo instance:

1. Copy the Spark distribution binary into the repo root. By default this is
   assumed to be `spark-1.1.0-bin-hadoop2.4.tgz`. See below if you wish to use
   a different Spark distro.
2. Copy the jobserver jar into the repo root. By default this is assumed to be
   `spark-job-server.jar`. Building the jobserver itself is easy: `pushd
   .../spark-jobserver; sbt clean assembly`.
3. Spin up the Vagrant instance: `vagrant up`
  - If you want to use a different Spark distro, set the `SPARK_DIST`
    environment variable (_without_ the extension):
    `SPARK_DIST=spark-1.1.0-bin-cdh4 vagrant up`
4. Now you can browse the Jobserver UI at <http://33.33.33.123:8090> and go
   through the [jobserver
   examples](https://github.com/spark-jobserver/spark-jobserver#wordcountexample-walk-through).

Note that this repo assumes RVM; YMMV with other installations such as ChefDK.
The Vagrant demo requires following plugins:

- [`vagrant-berkshelf`](https://github.com/berkshelf/vagrant-berkshelf)
- [`vagrant-omnibus`](https://github.com/opscode/vagrant-omnibus)

## Supported Platforms

Chefspec [tested on](spec/default_helper.rb):

```ruby
{
  'ubuntu' => [ '12.04', '13.04', '13.10', '14.04' ],
  'debian' => [ '6.0.5' ],
  'centos' => [ '5.8', '6.0', '6.3' ],
  'redhat' => [ '5.8', '6.3' ],
}
```

Confirmed to work on:

- Ubuntu 12.04
- Ubuntu 14.04

With Chef 11.8+

## Attributes

See [attributes](attributes/default.rb) for all options.

## Usage

The only cookbook dependency is runit; java is assumed to be installed somehow.

Follow the appropriate guides for Spark
[standalone](http://spark.apache.org/docs/latest/spark-standalone.html) or
[Mesos](http://spark.apache.org/docs/latest/running-on-mesos.html) deployment.
The relevant attributes are:

- `node.spark.jobserver.master_type`
- `node.spark.jobserver.master_url`

### spark-jobserver::default

Include `spark-jobserver::default` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[spark-jobserver::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
  - At least a Chefspec proving the fix; Test Kitchen coming later
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Matt Chu (matt.chu@gmail.com)
