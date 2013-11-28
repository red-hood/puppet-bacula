# = Class: bacula
#
# This class is the main class for bacula
#
#
# == Parameters
#
# Refer to docs/PARAMETERS.md # on the parameters used
#
#
class bacula (
  $manage_client           = params_lookup( 'manage_client' ),
  $manage_storage          = params_lookup( 'manage_storage' ),
  $manage_director         = params_lookup( 'manage_director' ),
  $manage_console          = params_lookup( 'manage_console' ),
  $manage_database         = params_lookup( 'manage_database' ),
  $database_backend        = params_lookup( 'database_backend' ),
  $database_host           = params_lookup( 'database_host' ),
  $database_port           = params_lookup( 'database_port' ),
  $database_name           = params_lookup( 'database_name' ),
  $database_user           = params_lookup( 'database_user' ),
  $database_password       = params_lookup( 'database_password' ),
  $pid_directory           = params_lookup( 'pid_directory' ),
  $heartbeat_interval      = params_lookup( 'heartbeat_interval'),
  $password_salt           = params_lookup( 'password_salt' ),
  $default_password        = params_lookup( 'default_password' ),
  $default_file_retention  = params_lookup( 'default_file_retention' ),
  $default_job_retention   = params_lookup( 'default_job_retention' ),
  $default_jobdef          = params_lookup( 'default_jobdef' ),
  $default_messages        = params_lookup( 'default_messages' ),
  $default_catalog         = params_lookup( 'default_catalog' ),
  $default_archive_device  = params_lookup( 'default_archive_device' ),
  $client_package          = params_lookup( 'client_package' ),
  $client_config_file      = params_lookup( 'client_config_file' ),
  $client_template         = params_lookup( 'client_template' ),
  $client_password         = params_lookup( 'client_password' ),
  $client_source           = params_lookup( 'client_source' ),
  $client_service          = params_lookup( 'client_service' ),
  $client_process          = params_lookup( 'client_process' ),
  $client_pid_file         = params_lookup( 'client_pid_file' ),
  $client_name             = params_lookup( 'client_name' ),
  $client_port             = params_lookup( 'client_port' ),
  $client_max_concurrent   = params_lookup( 'client_max_concurrent' ),
  $client_address          = params_lookup( 'client_address' ),
  $storage_package         = params_lookup( 'storage_package' ),
  $storage_config_file     = params_lookup( 'storage_config_file' ),
  $storage_password        = params_lookup( 'storage_password' ),
  $storage_template        = params_lookup( 'storage_template' ),
  $storage_source          = params_lookup( 'storage_source' ),
  $storage_service         = params_lookup( 'storage_service' ),
  $storage_process         = params_lookup( 'storage_process' ),
  $storage_name            = params_lookup( 'storage_name' ),
  $storage_address         = params_lookup( 'storage_address' ),
  $storage_port            = params_lookup( 'storage_port' ),
  $storage_max_concurrent  = params_lookup( 'storage_max_concurrent' ),
  $storage_configs_dir     = params_lookup( 'storage_configs_dir' ),
  $director_package        = params_lookup( 'director_package' ),
  $director_config_file    = params_lookup( 'director_config_file' ),
  $director_template       = params_lookup( 'director_template' ),
  $director_source         = params_lookup( 'director_source' ),
  $director_service        = params_lookup( 'director_service' ),
  $director_process        = params_lookup( 'director_process' ),
  $director_name           = params_lookup( 'director_name' ),
  $director_address        = params_lookup( 'director_address' ),
  $director_port           = params_lookup( 'director_port' ),
  $director_max_concurrent = params_lookup( 'director_max_concurrent' ),
  $director_password       = params_lookup( 'director_password' ),
  $director_configs_dir    = params_lookup( 'director_configs_dir' ),
  $director_clients_dir    = params_lookup( 'director_clients_dir' ),
  $console_package         = params_lookup( 'console_package' ),
  $console_config_file     = params_lookup( 'console_config_file' ),
  $console_password        = params_lookup( 'console_password'),
  $console_template        = params_lookup( 'console_template' ),
  $console_source          = params_lookup( 'console_source' ),
  $traymon_name            = params_lookup( 'traymon_name'),
  $traymon_password        = params_lookup( 'traymon_password'),
  $traymon_command         = params_lookup( 'traymon_command' ),
  $working_directory       = params_lookup( 'working_directory' ),
  $service_status          = params_lookup( 'service_status' ),
  $my_class                = params_lookup( 'my_class' ),
  $log_dir                 = params_lookup( 'log_dir' ),
  $log_file                = params_lookup( 'log_file' ),
  $protocol                = params_lookup( 'protocol' ),
  $process_args            = params_lookup( 'process_args' ),
  $process_user            = params_lookup( 'process_user' ),
  $process_group           = params_lookup( 'process_group' ),
  $source_dir              = params_lookup( 'source_dir' ),
  $source_dir_purge        = params_lookup( 'source_dir_purge' ),
  $service_autorestart     = params_lookup( 'service_autorestart' , 'global' ),
  $config_dir              = params_lookup( 'config_dir' ),
  $config_file_mode        = params_lookup( 'config_file_mode' ),
  $config_file_owner       = params_lookup( 'config_file_owner' ),
  $config_file_group       = params_lookup( 'config_file_group' ),
  $config_file_init        = params_lookup( 'config_file_init' ),
  $data_dir                = params_lookup( 'data_dir' ),
  $options                 = params_lookup( 'options' ),
  $version                 = params_lookup( 'version' ),
  $absent                  = params_lookup( 'absent' ),
  $disable                 = params_lookup( 'disable' ),
  $disableboot             = params_lookup( 'disableboot' ),
  $monitor                 = params_lookup( 'monitor' , 'global' ),
  $monitor_tool            = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target          = params_lookup( 'monitor_target' , 'global' ),
  $puppi                   = params_lookup( 'puppi' , 'global' ),
  $puppi_helper            = params_lookup( 'puppi_helper' , 'global' ),
  $firewall                = params_lookup( 'firewall' , 'global' ),
  $firewall_tool           = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src            = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst            = params_lookup( 'firewall_dst' , 'global' ),
  $debug                   = params_lookup( 'debug' , 'global' ),
  $audit_only              = params_lookup( 'audit_only' , 'global' ),
  $noops                   = params_lookup( 'noops' )
  ) inherits bacula::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  $bool_manage_client=any2bool($manage_client)
  $bool_manage_storage=any2bool($manage_storage)
  $bool_manage_director=any2bool($manage_director)
  $bool_manage_console=any2bool($manage_console)
  $bool_manage_database=any2bool($manage_database)

  ### Definition of some variables used in the module

  ### Set a default password if required
  if $default_password == 'auto' {
    $real_default_password = $bacula::password_salt ? {
      ''      => fqdn_rand(100000000000),
      default => fqdn_rand(100000000000,$bacula::password_salt),
    }
  } else {
    $real_default_password = $bacula::default_password
  }

  # $traymon_password is not set up anywhere else, so we get a default value
  # for it

  $real_traymon_password = $bacula::traymon_password ? {
    ''      => $bacula::real_default_password,
    default => $bacula::traymon_password,
  }

  $manage_package = $bacula::bool_absent ? {
    true  => 'absent',
    false => $bacula::version,
  }

  $manage_service_enable = $bacula::bool_disableboot ? {
    true    => false,
    default => $bacula::bool_disable ? {
      true    => false,
      default => $bacula::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $bacula::bool_disable ? {
    true    => 'stopped',
    default =>  $bacula::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_file = $bacula::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $bacula::bool_absent == true
  or $bacula::bool_disable == true
  or $bacula::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $bacula::bool_absent == true
  or $bacula::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $bacula::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $bacula::bool_audit_only ? {
    true  => false,
    false => true,
  }

  ### Resources common to all components

  group { $bacula::process_group:
    ensure => present,
  } ->
  user { $bacula::process_owner:
    ensure => present,
    gid    => 'bacula',
  }

  file { $bacula::working_directory:
    ensure  => directory,
    owner   => $bacula::process_owner,
    group   => $bacula::process_group,
    require => User[$bacula::process_owner],
  } ->
  file { '/var/lib/bacula':
    ensure => link,
    target => $bacula::working_directory,
  }

  file { 'bacula.dir':
    ensure  => directory,
    path    => $bacula::config_dir,
    recurse => true,
    owner   => $bacula::process_owner,
    group   => $bacula::process_group,
    purge   => $bacula::bool_source_dir_purge,
    force   => $bacula::bool_source_dir_purge,
    replace => $bacula::manage_file_replace,
    audit   => $bacula::manage_audit,
    require => User[$bacula::process_owner],
  }

  file { $bacula::log_dir:
    ensure  => directory,
    recurse => true,
    owner   => $bacula::process_owner,
    group   => $bacula::process_group,
    require => User[$bacula::process_owner],
  }

  file { '/var/run/bacula':
    ensure  => directory,
    owner   => $bacula::process_owner,
    group   => $bacula::process_group,
    require => User[$bacula::process_owner],
  }

  ### Managed resources
  #### Include related classes

  ### Client configuration
  if $bacula::bool_manage_client == true {
    include bacula::client
  }

  ### Storage configuration
  if $bacula::bool_manage_storage == true {
    include bacula::storage
  }

  ### Director configuration
  if $bacula::bool_manage_director == true {
    include bacula::director
  }

  ### Console configuration
  if $bacula::bool_manage_console == true {
    include bacula::console
  }

  ### Database configuration
  if $bacula::bool_manage_database == true {
    include bacula::database
  }

  ### Include custom class if $my_class is set
  if $bacula::my_class {
    include $bacula::my_class
  }
}
