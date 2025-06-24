# Puppet Itemize

Count the number of types, classes, functions used in manifest(s)

Run this command with a space separated list of either manifest file paths, or
directories containing manifests. If omitted, it will default to inspecting all
manifests in the manifests directory, so you can just run this in the root of a
Puppet module and it will do the right thing.

## Installation

Install as either a gem:

```
$ gem install puppet-itemize
```

Or as a Puppet module:

```
$ puppet module install binford2k/itemize
```

## Usage

Depending on how it's installed, there are two ways to run this. As the command
line tool, `puppet-itemize`, or as the Puppet subcommand, `puppet parser itemize`.
There are slight, but mostly insignificant differences in behaviour based on
which way you run it.

Basically, just invoke the tool with a list of manifest(s), or directories of
manifests, or just let it default to the `./manifests` directory.

If you'd like machine parsable outputs, then use the `--render-as` flag and
pass in a format of `json` or `yaml`.

### Command-line examples:
Available when installed via either gem or Puppet module.

```
$ puppet-itemize
$ puppet-itemize manifests
$ puppet-itemize manifests/init.pp
$ puppet-itemize manifests/init.pp manifests/example/path.pp
```

### Puppet subcommand examples:
Available only when installed via Puppet module.

```
$ puppet parser itemize
$ puppet parser itemize manifests
$ puppet parser itemize manifests/init.pp
$ puppet parser itemize manifests/init.pp manifests/example/path.pp
```

### Module dependency validation

If the tool can identify that you're running this on manifests within a Puppet
module, then it will validate the dependencies listed in the `metadata.json`.
By default, it will print out warnings for resources or classes that come from
modules that aren't declared as dependencies. Facts and Puppet 3.x style functions
aren't namespaced in the same way, so they cannot be identified, but Puppet 4.x
namespaced functions will trigger the same validation.

You can also use the `--external` argument. This will filter the output to only
show elements which are either global or from other modules. This can be used to
help identify how dependencies are being used.


### Programatic use

You can choose to render the output in either JSON or YAML for consumption by
other tools or testing pipelines by simply passing the `--render-as` argument:

```
$ puppet parser itemize ~/Projects/puppetlabs-apache/manifests/ --render-as json
$ puppet parser itemize ~/Projects/puppetlabs-apache/manifests/ --render-as yaml
```

It's also reasonably easy to invoke this as a library from Ruby tools. See the
`bin/puppet-itemize` script for an example.


### Example output:

Because this is static analysis prior to compilation, no variables can be
resolved.  Because of that, when a class name is calculated dynamically, any
variable parts of the name will be represented as `<??>`. See an example of that
below in the class list as `apache::mod::<??>`.

```
$ bundle exec puppet-itemize spec/fixtures/modules/apache
Warning: Undeclared module dependancy: portage::makeconf
Warning: create_resources detected. Please update to use iteration instead.
Resource usage analysis:
===========================================
>> types:
                         apache::mod | 143
                                file |  95
                    concat::fragment |  52
                       apache::vhost |  50
                             package |  16
                                exec |  14
                         apache::mpm |   7
                   portage::makeconf |   7
                              concat |   3
                      apache::listen |   2
                              anchor |   1
               apache::custom_config |   1
          apache::default_mods::load |   1
        apache::peruser::multiplexer |   1
         apache::security::rule_link |   1
             apache::vhost::fragment |   1
                               group |   1
                             service |   1
                                user |   1
                             yumrepo |   1

                          Totals: 20 | 399

>> classes:
                              apache |  80
             apache::mod::authn_core |  10
                  apache::mod::proxy |   9
             apache::mod::proxy_http |   6
            apache::mod::proxy_http2 |   6
                 apache::mod::filter |   5
                   apache::mod::mime |   5
         apache::mod::proxy_balancer |   5
                  apache::mod::alias |   4
                apache::mod::headers |   4
                apache::mod::rewrite |   4
             apache::mod::authz_core |   3
                    apache::mod::env |   3
                apache::mod::userdir |   3
            apache::mod::vhost_alias |   3
                apache::default_mods |   2
                   apache::mod::<??> |   2
                apache::mod::actions |   2
             apache::mod::auth_basic |   2
             apache::mod::authn_file |   2
        apache::mod::authz_groupfile |   2
             apache::mod::authz_user |   2
                    apache::mod::cgi |   2
                    apache::mod::dav |   2
                    apache::mod::dir |   2
                  apache::mod::http2 |   2
             apache::mod::mime_magic |   2
                    apache::mod::php |   2
             apache::mod::reqtimeout |   2
               apache::mod::setenvif |   2
                apache::mod::speling |   2
            apache::mod::ssl::reload |   2
                 apache::mod::suexec |   2
                apache::mod::version |   2
                      apache::params |   2
              apache::confd::no_accf |   1
         apache::default_confd_files |   1
            apache::mod::auth_gssapi |   1
              apache::mod::auth_kerb |   1
           apache::mod::auth_openidc |   1
              apache::mod::autoindex |   1
                  apache::mod::cache |   1
             apache::mod::cache_disk |   1
                   apache::mod::cgid |   1
                 apache::mod::dav_fs |   1
                    apache::mod::dbd |   1
                apache::mod::deflate |   1
                    apache::mod::dev |   1
             apache::mod::disk_cache |   1
             apache::mod::ext_filter |   1
                apache::mod::fastcgi |   1
                   apache::mod::info |   1
                     apache::mod::jk |   1
                   apache::mod::ldap |   1
           apache::mod::log_forensic |   1
                     apache::mod::md |   1
            apache::mod::negotiation |   1
              apache::mod::passenger |   1
                apache::mod::prefork |   1
          apache::mod::socache_shmcb |   1
                    apache::mod::ssl |   1
                 apache::mod::status |   1
               apache::mod::watchdog |   1
                   apache::mod::wsgi |   1
      apache::mpm::disable_mpm_event |   1
    apache::mpm::disable_mpm_prefork |   1
     apache::mpm::disable_mpm_worker |   1
                     apache::package |   1
                     apache::service |   1
                                epel |   1

                          Totals: 70 | 225

>> functions:
                                fail |  94
                                 epp |  82
                          versioncmp |  62
                             defined |  48
                               empty |  25
                            template |  16
                            regsubst |  14
                                each |   7
                             warning |   6
                         deprecation |   5
                                pick |   5
                     inline_template |   4
                                join |   4
                           any2array |   3
                     ensure_resource |   3
                             flatten |   3
                               split |   3
                               array |   2
                              concat |   2
              stdlib::deferrable_epp |   2
                    create_resources |   1
                            deferred |   1
                        enclose_ipv6 |   1
                              prefix |   1
                              string |   1

                          Totals: 25 | 395
```


## Limitations

This is super early in development and has not yet been battle tested.


## Disclaimer

I take no liability for the use of this tool.


Contact
-------

binford2k@gmail.com
