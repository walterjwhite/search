_search_git_branches() {
	git branch -a | grep --color $_OPTIONS "$1"
}
