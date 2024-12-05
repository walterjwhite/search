_search_git_contents() {
	if [ $# -eq 0 ]; then
		_warn "Not searching contents as no search argument was provided."
		return
	fi

	for _ARG in "$@"; do
		case $_ARG in
		--before=*)
			shift
			;;
		--after=*)
			shift
			;;
		-i | -v | -l)
			_OPTIONS="${_OPTIONS:+$_OPTIONS }$_ARG"
			shift
			;;
		*)
			break
			;;
		esac
	done

	for _ARG in "$@"; do
		case $_ARG in
		*)
			if [ -n "$_CONTENTS_SEARCH" ]; then
				_warn "Excluding arg: $_ARG"
				continue
			fi

			_CONTENTS_SEARCH=$(printf "$_ARG" | sed -e 's/^-/\\-/')
			;;
		esac
	done

	: ${_SEARCH_COMMITS:=current}
	_search_git_contents_get_type

	if [ $_CONF_SEARCH_CONTENTS_RECURSE_SUBMODULES -eq 1 ]; then
		_OPTIONS="${_OPTIONS:+$_OPTIONS }--recurse-submodules"
	fi

	if [ "$_SEARCH_XEDIT" ]; then
		_git_contents_xedit
	elif [ "$_SEARCH_EDIT" ]; then
		_git_contents_edit
	elif [ "$_SEARCH_FILES" ]; then
		_git_contents_files
	else
		_git_contents_search
	fi
}

_git_contents_search() {
	_OPTIONS="${_OPTIONS:+$_OPTIONS }-n"
	_git_contents_search_$_SEARCH_COMMITS
}

_git_contents_search_current() {
	git grep $_OPTIONS "$_CONTENTS_SEARCH" $_SEARCH_BRANCH
}

_git_contents_search_any() {
	git rev-list --all | xargs _git_contents_search_current
}

_git_contents_search_all() {
	for _SEARCH_BRANCH in $(git branch); do
		_detail " searching contents in $_SEARCH_BRANCH"
		_git_contents_search_current
	done
}

_git_contents_edit() {
	_OPTIONS="${_OPTIONS:+$_OPTIONS }-l"
	$_CONF_SEARCH_EDITOR $(_git_contents_search_current)
}

_git_contents_xedit() {
	_OPTIONS="${_OPTIONS:+$_OPTIONS }-l"
	$_CONF_SEARCH_XEDITOR $(_git_contents_search_current)
}

_git_contents_files() {
	_OPTIONS="${_OPTIONS:+$_OPTIONS }-l"
	$_CONF_SEARCH_FILE_MANAGER $(dirname $(_git_contents_search_current) | sort -u)
}

_search_git_contents_get_type() {
	case $_CONF_SEARCH_CONTENTS_TYPE in
	string)
		_OPTIONS="${_OPTIONS:+$_OPTIONS }-F"
		;;
	regex)
		_OPTIONS="${_OPTIONS:+$_OPTIONS }-G"
		;;
	*)
		_error "Unknown search type: $_CONF_SEARCH_CONTENTS_TYPE"
		;;
	esac
}
