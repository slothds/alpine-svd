#!/usr/bin/env bash
PATH='/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'
_exec=( supervisord )

__terminate_svc() {
    echo "Stopping services..."
    sleep 2
    kill -TERM $(cat /var/run/supervisord.pid)
}

__reconfigs_svc() {
    echo "Reload configuration..."
    sleep 2
    kill -HUP  $(cat /var/run/supervisord.pid) 
}

# Including and exporting ENV configs
set -o allexport
for _env in /exec/env.d/*.env
do
    . ${_env}
done
set +o allexport

# Executing prestart init scripts.
for _init in /exec/init.d/*.sh
do
    . ${_init}
done

#!/usr/bin/env bash
trap __reconfigs_svc HUP
trap __terminate_svc INT QUIT TERM

eval exec ${_exec[@]} $@
