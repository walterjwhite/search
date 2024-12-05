_search_git_activity() {
	if [ ! -e $_PROJECT_PATH/.activity ]; then
		_warn "No activity in $_PROJECT_PATH/.activity"
		return
	fi

}
