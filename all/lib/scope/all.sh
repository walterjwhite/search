_search_all() {
	if [ -z "$_PROJECT_BASE_PATH" ] && [ -z "$_CONF_INSTALL_DATA_PATH" ]; then
		_CONF_SEARCH_PATH="."
	else
		_CONF_SEARCH_PATH="$_PROJECT_BASE_PATH $_CONF_INSTALL_DATA_PATH"
	fi

	_SEARCH_PATH="$_CONF_SEARCH_PATH" _search_recursive "$@"
}
