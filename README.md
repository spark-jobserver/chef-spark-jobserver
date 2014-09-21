# spark-jobserver cookbook

Installs the [Spark Jobserver](../spark-jobserver/spark-jobserver).

Quickstart:

```ruby
# minimal required configuration; these values have no defaults and must be provided

# path to your spark install
node.spark.jobserver.spark_home = '/usr/local/spark'
node.spark.jobserver.spark_conf_dir = '/etc/spark'

# you need to provide the jobserver jar
node.spark.jobserver.jar_url = 'https://domain.com/some/path/spark-job-server.jar'

include_recipe 'spark-jobserver::default'
```

To use the provided [Vagrantfile](Vagrantfile) to spin up a test instance:

1. Copy the Spark distribution binary into the repo root. Something like
   `spark-1.0.2-bin-hadoop2.tgz`.
2. Copy the jobserver jar and the jobserver sample app jar into the repo root.
   Something like `spark-job-server.jar` and `job-server-tests-0.3.1.jar`.
   [Build instructions](TODO).
3. Spin up the Vagrant instance: `vagrant up`
4. Now you can browse the Jobserver UI at <http://33.33.33.123:8090> and go
   through the [jobserver
   examples](https://github.com/spark-jobserver/spark-jobserver#wordcountexample-walk-through).

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

With Chef 11.8+

## Attributes

See [attributes](attributes/default.rb) for all options.

## Usage

The only cookbook dependency is runit; java is assumed to be installed somehow.

### With Spark Standalone

### With Spark on Mesos

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
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Matt Chu (matt.chu@gmail.com)
