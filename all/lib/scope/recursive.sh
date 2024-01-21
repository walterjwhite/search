_search_recursive() {
	_CONF_INSTALL_NO_PAGER=$_CONF_SEARCH_RECURSIVE_PAGER

	_SEARCH_SCOPE=base
	_SEARCH_RECURSIVE=1

	find . \( -type d -or -type f \) -name '.git' -execdir search "$@" \;
}
