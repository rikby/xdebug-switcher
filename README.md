# xdebug-switcher
Status switcher for extension PHP Xdebug.

## Download latest version
```shell
$ curl -Ls https://raw.github.com/rikby/xdebug-switcher/master/download | bash
```

## Help output
```
PHP XDebug extension switcher.
Commands:
  Toggle status
    $ xd_swi
    XDebug is enabled

  Show this help
    $ xd_swi -h

  Push to ON
    $ xd_swi 1|on
    XDebug is enabled

  Push to OFF
    $ xd_swi 0|off
    XDebug is disabled

  Show status as integer 1 or 0
    $ xd_swi stat
    1

  Show status as a message
    $ xd_swi status
    XDebug enabled

  Run version/date
    $ xd_swi -v

  Run self update
    $ xd_swi self-update
```
