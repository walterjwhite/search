_search_git_tags() {
	git tag | grep --color $_OPTIONS "$1"
}
