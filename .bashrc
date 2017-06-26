# Source global definitions
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

# init once
if [ -z "${BASHRC_INIT}" ]; then
    BASHRC_INIT=1
    readonly BASHRC_INIT

    ORIGINAL_PATH=${PATH}
    readonly ORIGINAL_PATH
fi

PATH=${ORIGINAL_PATH}
PATH=${PATH}':'$(cd; pwd)'/.composer/vendor/bin'

alias ls='ls --color'
alias ll='ls -la'

export TERM=xterm
export SHELL=bash

# Colorize PS1 console
# curl -Ls https://gist.github.com/andkirby/389f18642fc08d1b0711d17978445f2b/raw/bashrc_ps1_install.sh | bash
PS1="\n\[\033[01;37m\]\$? "
PS1=${PS1}"\$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi)"
PS1=${PS1}" $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[0;32m\]\u@\h'; fi)"
PS1=${PS1}" \[\033[00m\]\D{%T}\[\033[0;33m\] \w\[\033[00m\] \n\$ "
# EOF Colorize PS1 console
