#!/bin/bash
RUID=${RUID:-10001}
RGID=${RGID:-10001}
WDIR=${WDIR:-/opt/home}

usrmod=( usermod )
grpmod=( groupmod )
[ "$(id -u runner)" != "${RUID}" ] && usrmod+=( --non-unique --uid ${RUID} )
[ "$(id -g runner)" != "${RGID}" ] && usrmod+=( --gid ${RGID} ) && grpmod+=( --non-unique --gid ${RGID} )
[ "$(grep 'runner' /etc/passwd | cut -d':' -f6)" != "${WDIR}" ] && usrmod+=( --home ${WDIR} --move-home )
[ "$(grep 'runner' /etc/passwd | cut -d':' -f7)" != "/bin/false" ] && usrmod+=( --shell '/bin/false' )

[ "${usrmod[@]}" != "usermod" ]  && ${usrmod[@]} runner
[ "${grpmod[@]}" != "groupmod" ] && ${grpmod[@]} runner
