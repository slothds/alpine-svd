#!/usr/bin/env bash
_curent=`crontab -l 2>/dev/null`

if [ -z "${_curent}" ];then
cat <<-EOF | crontab -u root -
# do daily/weekly/monthly maintenance
# min   hour    day     month   weekday command
*/15    *       *       *       *       run-parts /etc/periodic/15min
0       *       *       *       *       run-parts /etc/periodic/hourly
0       0       *       *       *       run-parts /etc/periodic/daily
0       3       *       *       6       run-parts /etc/periodic/weekly
0       6       1       *       *       run-parts /etc/periodic/monthly
EOF
fi
