# xdebug-switcher
Status switcher for extension PHP Xdebug.

## Download latest version
```shell
$ curl -Ls https://raw.github.com/rikby/xdebug-switcher/master/download | bash
```
Or get downloader help
```
$ curl -Ls https://raw.github.com/rikby/xdebug-switcher/master/download | bash -s -- --help
```

## Supported OS
It's was tested in 
- Windows GitBash console tool
```
$ bash --version
GNU bash, version 4.3.46(2)-release (x86_64-pc-msys)
```
- and in CentoOS
```
$ bash --version
GNU bash, version 4.2.46(1)-release (x86_64-redhat-linux-gnu)
```

## Usage
### Toggle status
```
$ xd_swi
XDebug is enabled
```
### Set a particular status
```
$ xd_swi on
XDebug is enabled
```

Please use `xd_swi --help` to get more information about options.

### Help output
```
PHP XDebug extension switcher.
Commands:
  Toggle status
    $ xd_swi
    XDebug is enabled

  Show this help
    $ xd_swi -h

  Disable Xdebug
    $ xd_swi 1|on
    XDebug is enabled

  Enable Xdebug
    $ xd_swi 0|off
    XDebug is disabled

  Show Xdebug status as integer 1 or 0
    $ xd_swi stat
    1

  Show status as a message (colored)
    $ xd_swi status
    XDebug enabled

  Get version
    $ xd_swi -v|--version
    v0.2.0

  Get path to XDebug configuration INI file
    $ xd_swi file

  Run self update
    $ xd_swi self-update

  Define custom command to restart a service after changed status, e.g. php-fpm
  (please don't use sudo because it will be used automatically if it's installed)
    $ xd_swi restart-command -- supervisorctl restart php-fpm

  Run xd_swi to toggle Xdebug status without restarting service.
    $ xd_swi -n|--no-restart
```

### Custom PHP binary path
You may declare your custom PHP binary path by setting environment variable `XD_SWI_PHP_BIN`.

## Run tests
Here an example of successful tests.
``` Shell
0 ✓ vagrant 19:40:33 /srv/html/xdebug-switcher
$ docker-compose up
[...]
Starting xd-swi
Attaching to xd-swi
xd-swi | 1..9
xd-swi | ok 1 Check short status.
[...]
xd-swi exited with code 0
```
