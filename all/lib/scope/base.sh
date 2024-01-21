_search_base() {
	if [ $_CONF_SEARCH_CWD_ONLY -eq 0 ]; then
		unset _GIT_NO_INIT_PROJECT_DIRECTORY
	fi

	[ $_SEARCH_BRANCHES ] && _SEARCH_TYPE=branches _do_search_base "$@"
	[ $_SEARCH_TAGS ] && _SEARCH_TYPE=tags _do_search_base "$@"
	[ $_SEARCH_FILENAMES ] && _SEARCH_TYPE=filenames _do_search_base "$@"
	[ $_SEARCH_CHANGES ] && _SEARCH_TYPE=changes _do_search_base "$@"
	[ $_SEARCH_LOGS ] && _SEARCH_TYPE=logs _do_search_base "$@"

	[ $_SEARCH_CONTENTS ] || [ -z $_SEARCHED ] && _SEARCH_TYPE=contents _do_search_base "$@"
}

_do_search_base() {
	[ $_SEARCH_RECURSIVE ] || _detail "Searching $_SEARCH_TYPE @ $_PROJECT: $*"
	_search_${_SEARCH_TYPE} "$@"

	_SEARCHED=1
}
