#!/usr/bin/env bash

bin_file=xd_swi

if [ -f /code/${bin_file} ] && [ ! -L /usr/local/bin/${bin_file} ] ; then
  ln -s /code/${bin_file} /usr/local/bin/${bin_file}
  chmod +x /usr/local/bin/${bin_file} /code/${bin_file}
fi

$@
