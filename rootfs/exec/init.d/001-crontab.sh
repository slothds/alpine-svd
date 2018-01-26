#!/bin/bash

for _ctab in /etc/crontab.d/*.crontab
do
    if [ -f ${_ctab} ]; then
        /usr/bin/crontab -u $(echo "${_ctab}" | cut -d'.' -f1) ${_ctab}
    fi
done
