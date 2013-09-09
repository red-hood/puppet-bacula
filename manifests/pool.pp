define bacula::pool (
  $pool_name = '',
  $pool_type = '',
  $maximum_volume_jobs = '',
  $maximum_volume_bytes = '',
  $use_volume_once  = '',
  $recycle = '',
  $action_on_purge = '' ,
  $auto_prune = '',
  $volume_retention = '',
  $label_format = '' {

  include bacula

  $concat_host_file = "${dnsmasq::addn_hosts_dir}/${order}-${file}"

  if ! defined(Concat["${concat_host_file}"]) {
    concat { "${concat_host_file}":
      mode    => '0644',
      warn    => true,
      owner   => $bacula::config_file_owner,
      group   => $bacula::config_file_group,
      require => Package['bacula'],
    }
  }
}

