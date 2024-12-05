_search_git_changes() {
	if [ $# -eq 0 ]; then
		_warn "Not searching changes as no search argument was provided."
		return
	fi

	for _ARG in "$@"; do
		case $_ARG in
		-i)
			_OPTIONS="${_OPTIONS:+$_OPTIONS }$_ARG"
			;;
		*)
			if [ -n "$_CHANGE_SEARCH" ]; then
				_warn "Excluding arg: $_ARG"
				continue
			fi

			_CHANGE_SEARCH=$(printf "$_ARG" | sed -e 's/^-/\\-/')
			;;
		esac
	done

	if [ "$_SEARCH_ALL_BRANCHES" ]; then
		_search_git_changes_all
		return
	fi

	_search_git_changes_do
}

_search_git_changes_do() {
	git log $_SEARCH_BRANCH -p $_OPTIONS -G "$_CHANGE_SEARCH"
}

_search_git_changes_all() {
	for _SEARCH_BRANCH in $(git branch); do
		_detail "Searching changes in $_SEARCH_BRANCH"
		_search_git_changes_do
	done
}
