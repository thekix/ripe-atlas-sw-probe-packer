#!/usr/bin/env bash

PACKAGE_NAME='atlasswprobe'
KEY_FILE='/var/atlas-probe/etc/probe_key.pub'

dpkg -l ${PACKAGE_NAME} 2> /dev/null 1>&2
if [ $? != 0 ]; then
	dpkg -i /root/atlasswprobe-*.deb
	echo '---------------------------------'
	echo '  THE PUBLIC KEY FOR THIS IMAGE'
	echo '---------------------------------'
	echo "This file is at ${KEY_FILE}"
	echo '---------------------------------'
fi

sed -i "s/\/root\/atlas_check.sh//" /etc/rc.local
exit 0
