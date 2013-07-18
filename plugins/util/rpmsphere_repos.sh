# Name: Configure RPM Sphere repository
# Command: rpmsphere_repos

rpmsphere_repos() {
show_func "Configuring RPM Sphere repository"
add_repo "rpmsphere.repo"
[[ "$(rpmsphere_repos_test)" = "Configured" ]]; exit_state
}

rpmsphere_repos_test() {
check_repo "rpmsphere.repo"
if [[ $? -eq 0 ]]; then
	printf "Configured"
else
	printf "Not configured"
fi
}