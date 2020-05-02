#!/bin/bash


echo "set password from: ${KODIUSERNAME}"
#usermod -p "${KODIUSERPWD}" ${KODIUSERNAME}
#echo "${KODIUSERPWD}" | passwd --stdin ${KODIUSERNAME}
echo -e "${KODIUSERPWD}\n${KODIUSERPWD}" | passwd ${KODIUSERNAME}

/etc/init.d/xrdp start

# Stop script
stop_script() {
	echo "stopping container ..."
	/etc/init.d/xrdp stop
	exit 0
}
# catch signals
trap stop_script SIGINT SIGTERM SIGKILL


while true; do
    #uptime
    sleep 10
	pgrep xrdp > /dev/null || exit 0
done
