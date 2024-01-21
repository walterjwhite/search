_search_tags() {
	git tag | grep --color $_OPTIONS "$1"
}
