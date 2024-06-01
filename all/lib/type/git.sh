import git:install/path.sh

_get_search_git_scope() {
	_GIT_WARN=1 _get_project_directory && {
		_SEARCH_SCOPE=.
		return
	}

	_in_path "$_PROJECT_BASE_PATH" && {
		_SEARCH_SCOPE=recursive
		return
	}

	_in_path "$_CONF_INSTALL_DATA_PATH" && {
		_SEARCH_SCOPE=recursive
		return
	}

	_SEARCH_SCOPE=all
}

_search_git_wd() {
	[ $_CONF_SEARCH_CWD_ONLY -eq 0 ] && unset _GIT_NO_INIT_PROJECT_DIRECTORY

	[ $_SEARCH_RECURSIVE ] || _detail "Searching $_SEARCH_FUNCTION @ $_PROJECT: $*"
	_search_${_SEARCH_FUNCTION} "$@"
}

_search_git_recursive() {
	_CONF_INSTALL_NO_PAGER=$_CONF_SEARCH_RECURSIVE_PAGER

	_SEARCH_RECURSIVE=1
	[ -z "$_SEARCH_PATH" ] && _SEARCH_PATH=.

	_SEARCH_SCOPE=. find $_SEARCH_PATH \( -type d -or -type f \) -name '.git' -execdir search "$@" \;
}

_search_git_all() {
	if [ -z "$_PROJECT_BASE_PATH" ] && [ -z "$_CONF_INSTALL_DATA_PATH" ]; then
		_SEARCH_PATH="."
	else
		_SEARCH_PATH="$_PROJECT_BASE_PATH $_CONF_INSTALL_DATA_PATH"
	fi

	_search_git_recursive "$@"
}
