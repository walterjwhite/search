_search_branches() {
	git branch -a | grep --color $_OPTIONS "$1"
}
