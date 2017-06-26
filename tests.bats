#!/usr/bin/env bats
# Run tests by using bats
# https://github.com/sstephenson/bats

ERR_FATAL=1
ERR_LOGIC=2
ERR_PARAMS=3
ERR_FILE_SYSTEM=4
ERR_CONNECTION=6 # failed test for connection

status=0
output=''

# drop status
echo ';zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so' \
      > /usr/local/etc/php/conf.d/100-xdebug.ini

@test "Check short status." {
  export BASH_NO_COLOR=1
  run xd_swi stat
  [ "${status}" -eq 0 ]
  [ "${output}" -eq 0 ]
}

@test "Check long status." {
  export BASH_NO_COLOR=1
  run xd_swi status
  [ "${status}" -eq 0 ]
  [ "${output}" == 'XDebug is disabled' ]
}

@test "Disable with '1'." {
  export BASH_NO_COLOR=1
  run xd_swi 1
  [ "${status}" -eq 0 ]
  [ "${output}" == 'XDebug is enabled' ]
}

@test "Disable with '0'." {
  export BASH_NO_COLOR=1
  run xd_swi 0
  [ "${status}" -eq 0 ]
  [ "${output}" == 'XDebug is disabled' ]
}

@test "Disable with 'on'." {
  export BASH_NO_COLOR=1
  run xd_swi on
  [ "${status}" -eq 0 ]
  [ "${output}" == 'XDebug is enabled' ]
}

@test "Disable with 'off'." {
  export BASH_NO_COLOR=1
  run xd_swi off
  [ "${status}" -eq 0 ]
  [ "${output}" == 'XDebug is disabled' ]
}
