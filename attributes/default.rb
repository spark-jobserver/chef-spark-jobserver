# installation and service attributes

default.spark.jobserver.user = 'vagrant'
default.spark.jobserver.group = 'vagrant'

default.spark.jobserver.spark_home = nil
default.spark.jobserver.spark_conf_dir = nil

default.spark.jobserver.jar_url = 'https://github.com/mattchukabam/spark-jobserver/releases/download/0.0.1/spark-job-server.jar'

default.spark.jobserver.port = 8899
default.spark.jobserver.service_actions = [ :enable, :start ]

default.spark.jobserver.install_dir = '/opt/spark-jobserver'
default.spark.jobserver.log_dir = '/var/log/spark-jobserver'
default.spark.jobserver.env_name = 'local'

# spark configuration

# one of standalone or mesos
default.spark.jobserver.master_type = 'standalone'

default.spark.jobserver.master_url = 'local[3]'

# standalone only
default.spark.jobserver.standalone.num_cpu = 2

# mesos only
default.spark.jobserver.mesos.spark_executor_uri = nil

# config file(s) attributes

default.spark.jobserver.data_dir = '/var/spark-jobserver'
default.spark.jobserver.jar_dir = '/var/spark-jobserver/jars'
default.spark.jobserver.file_dir = '/var/spark-jobserver/filedao'

default.spark.jobserver.default_context_settings = {
  'num_cpu' => 2,
  'memory' => '512m',
}

# these are created on startup; none are created by default, an example is provided below if you want this
default.spark.jobserver.default_contexts = { }
#default.spark.jobserver.default_contexts = {
#  'context-name' => {
#    'num_cpu' => 2,
#    'memory' => '512m',
#  },
#}

default.spark.jobserver.gc_opts = [
  '-XX:+UseConcMarkSweepGC',
  '-verbose:gc',
  '-XX:+PrintGCTimeStamps',
  '-Xloggc:$appdir/gc.out',
  '-XX:MaxPermSize=512m',
  '-XX:+CMSClassUnloadingEnabled',
]

default.spark.jobserver.java_opts = [
  '-XX:MaxDirectMemorySize=512M',
  '-XX:+HeapDumpOnOutOfMemoryError',
  '-Djava.net.preferIPv4Stack=true',
  # additional settings; from the spark-jobserver examples
  #'-Xmx5g',
  #'-Dcom.sun.management.jmxremote.port=9999',
  #'-Dcom.sun.management.jmxremote.authenticate=false',
  #'-Dcom.sun.management.jmxremote.ssl=false',
]
