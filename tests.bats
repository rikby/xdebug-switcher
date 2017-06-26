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

xdebug_ini_file=${XDEBUG_INI}

# reset status to "OFF"
echo ';zend_extension = '${XDEBUG_EXT} \
      > ${xdebug_ini_file}

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

@test "Enable with '1'." {
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

@test "Enable with 'on'." {
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

@test "Read path to Xdebug INI file." {
  export BASH_NO_COLOR=1
  run xd_swi file
  [ "${status}" -eq 0 ]
  [ "${output}" == ${xdebug_ini_file} ]
}

@test "Trigger restart command." {
  export BASH_NO_COLOR=1
  rm -f /tmp/test-command.txt \
        /usr/local/lib/xd_swi-restart-command
  run xd_swi 0
  echo 'echo 1 > /tmp/test-command.txt' > /tmp/test-run.sh

  run xd_swi restart-command -- bash /tmp/test-run.sh /tmp/test-command.txt
  run xd_swi

  [ "${status}" -eq 0 ]
  [ 'XDebug is enabled' == "${output:-}" ]
  [ -f /usr/local/lib/xd_swi-restart-command ]
  [ "$(cat /tmp/test-command.txt)" == '1' ]
}

@test "Omitting restart command." {
  export BASH_NO_COLOR=1

  rm -f /tmp/test-command.txt \
        /usr/local/lib/xd_swi-restart-command
  run xd_swi 0
  echo 'echo 1 > /tmp/test-command.txt' > /tmp/test-run.sh

  run xd_swi restart-command -- bash /tmp/test-run.sh /tmp/test-command.txt

  # it must not trigger "restart-command"
  run xd_swi --no-restart

  [ "${status}" -eq 0 ]
  [ 'XDebug is enabled' == "${output:-}" ]
  [ ! -f /tmp/test-command.txt ]
}
