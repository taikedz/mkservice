# Expectancies:
#
# SYSV_COMMAND
# SYSV_APP
# SYSV_NICENAME
# SYSV_DEFAULTSTART="2 3 4 5"
# SYSV_DEFAULTSTOP="0 1 6"

main() {
	# We need to get the arguments
	# Then make a temp and write a file
	# Do replaements
	# Move the temp to the target location
	# Print message about chkconfig
}

write_sysvinit_file() {
	local tempfile="$1"; shift
cat <<'EOSYSVTEMPLATE' > "$tmpfile"
#!/bin/bash
### BEGIN INIT INFO
# Provides: %%SYSV_APP%%
# Required-Start:
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: %%SVS_DESCRIPTION%%
### END INIT INFO

echoe() {
	echo "$*" >&2
}

faile() {
	echoe "$*"
	exit 1
}

[[ -z "$*" ]] && faile "Actions: start, stop, restart, status"

sysv_helper_init() {
	logfile="/var/log/%%SYSV_APP%%/%%SYSV_APP%%-$(date +%F).log"
	pidfile="/run/%%SYSV_APP%%.pid"

	pidnum=
	[[ -f "$pidfile" ]] && pidnum="$(cat "$pidfile")"
}

check_not_running() {
	[[ -z "$pidnum" ]]
	return $?
}

register_pid() {
	echo "$1" > "$pidfile"
}

start_service() {
	check_not_running || faile "%%SYSV_NICENAME%% is already running ($pidnum)"

	%%SYSV_COMMAND%% >> "$logfile" 2>&1 &
	register_pid "$!"
}

stop_service() {
	check_not_running && faile "%%SYSV_NICENAME%% is not running."

	echoe "Stopping $pidnum : %%SYSV_NICENAME%% ..."
	kill "$pidnum" #FIXME add an option to kill -9
}

restart_service() {
	set -e
	$0 stop
	$0 start
	set +e
}

service_status() {
	check_not_running && echoe "%%SYSV_NICENAME%% : running" || echoe "%%SYSV_NICENAME%% : stopped"
}

case "$1" in
	start) start_service ;;

	stop) stop_service ;;

	restart) restart_service ;;

	status) service_status ;;

	*) faile "Unknown command [$1]" ;;
esac

EOSYSVTEMPLATE
}
