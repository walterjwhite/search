_search_filenames() {
	[ "$_SEARCH_EDIT" ] && _POST_ARGS="-exec $_CONF_SEARCH_EDITOR {} +"
	[ "$_SEARCH_XEDIT" ] && _POST_ARGS="-exec $_CONF_SEARCH_XEDITOR {} +"
	[ "$_SEARCH_FILES" ] && _POST_ARGS="-execdir $_CONF_SEARCH_FILE_MANAGER {} ;"

	for _ARG in "$@"; do
		case $_ARG in
		-i)
			_CASE_INSENSITIVE_SEARCH=i
			;;
		*)
			_FIND_ARGS="-and ( -${_CASE_INSENSITIVE_SEARCH}name $_ARG -or -${_CASE_INSENSITIVE_SEARCH}path $_ARG )"
			;;
		esac
	done

	local search_path=$_PROJECT_PATH_PWD
	[ $search_path ] && search_path=. || {
		[ $_SEARCH_RECURSIVE ] && search_path=$PWD || search_path=.
	}

	find $search_path \
		\( -type f -or -type l \) -and ! -path '*/.git/*' \
		$_FIND_ARGS $_POST_ARGS
}
