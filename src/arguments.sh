#%include out.sh

S_USER=nobody
S_RESTART=always
S_AFTER=network.target
S_WANTEDBY=default.target

S_OVERWRITE=false

parse_arguments() {
	while [[ -n "$*" ]]; do
		local token="$1"; shift

		case "$token" in
		-d)
			S_DESCRIPTION="$1"; shift
			;;
		-u)
			S_USER="$(varify_var "$1")"; shift
			;;
		-r)
			S_RESTART="$(validate_restart "$1")"
			;;
		-n)
			S_SERVICENAME="$(varify_fil "$1")"; shift
			;;
		-a)
			S_AFTER="$1"; shift
			;;
		-w)
			S_WANTEDBY="$1"; shift
			;;
		--overwrite)
			S_OVERWRITE=true
			;;
		-f)
			S_SERVICEFILE="$1"; shift
			;;
		--)
			S_COMMAND=("$@")
			return
			;;
		esac
	done
}

validate_restart() {
	local rpat="^(no|on-success|on-failure|on-abnormal|on-watchdog|on-abort|always)$"
	local rpolicy="$1"; shift

	[[ "$rpolicy" =~ $rpat ]] && echo "$rpolicy" || out:fail "Invalid restart policy $rpolicy"
}

verify_arguments() {
	( [[ -n "${S_DESCRIPTION:-}" ]] &&
	  [[ -n "${S_COMMAND:-}" ]] &&
	  [[ -n "${S_SERVICENAME:-}" ]] ) || out:fail "Not enough information. Please see 'mkservice --help' for more info"
}
