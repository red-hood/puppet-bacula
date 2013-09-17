define bacula::director::catalog (
  $catalog_name = '',
  $db_driver = '',
  $db_address = '',
  $db_port = '',
  $db_name = '',
  $db_user = '',
  $db_password = '' {

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
