#!/bin/bash

spath="$(dirname "$0")"

[[ "$UID" = 0 ]] || {
	echo "You need to be root to run this script"
	exit 1
}

cp "$spath/bin/mkservice" /usr/local/bin/mkservice
chmod 755 /usr/local/bin/mkservice
