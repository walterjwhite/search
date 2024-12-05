_get_search_filenames_scope() {
	_SEARCH_SCOPE=.
}

_search_filenames_wd() {
	_SEARCH_FILENAMES_PATH=.
	_search_filenames_do "$@"
}

_search_filenames_all() {
	_SEARCH_FILENAMES_PATH="$_PROJECT_BASE_PATH $_CONF_INSTALL_DATA_PATH"
	_search_filenames_do "$@"
}

_search_filenames_system() {
	if [ ! -e $_CONF_SEARCH_LOCATE_DATABASE ]; then
		_warn "Initializing locate database"
		$_CONF_SEARCH_LOCATE_UPDATEDB_CMD
	fi

	locate "$@"
}

_search_filenames_do() {
	[ "$_SEARCH_EDIT" ] && _POST_ARGS="-exec $_CONF_SEARCH_EDITOR {} +"
	[ "$_SEARCH_XEDIT" ] && _POST_ARGS="-exec $_CONF_SEARCH_XEDITOR {} +"
	[ "$_SEARCH_FILES" ] && _POST_ARGS="-execdir $_CONF_SEARCH_FILE_MANAGER {} ;"

	set -o noglob

	for _ARG in "$@"; do
		case $_ARG in
		-i)
			_CASE_INSENSITIVE_SEARCH=i
			;;
		-l) ;;
		*)
			_FIND_ARGS="-${_CASE_INSENSITIVE_SEARCH}path $_ARG"
			;;
		esac
	done

	find $_SEARCH_FILENAMES_PATH \
		\( -type f -or -type l \) -and ! -path '*/.git/*' \
		$_FIND_ARGS $_POST_ARGS
}
