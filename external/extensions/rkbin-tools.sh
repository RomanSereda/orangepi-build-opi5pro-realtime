function fetch_sources_tools__rkbin_tools() {
	fetch_from_repo "https://github.com/orangepi-xunlong/rk-rootfs-build" "${EXTER}/cache/sources/rkbin-tools" "branch:rkbin"
}

function build_host_tools__install_rkbin_tools() {
	# install only if git commit hash changed
	cd "${EXTER}"/cache/sources/rkbin-tools || exit
	# need to check if /usr/local/bin/loaderimage to detect new Docker containers with old cached sources
	if [[ ! -f .commit_id || $(improved_git rev-parse @ 2>/dev/null) != $(<.commit_id) || ! -f /usr/local/bin/loaderimage ]]; then
		display_alert "Installing" "rkbin-tools" "info"
		mkdir -p /usr/local/bin/
		install -m 755 tools/loaderimage /usr/local/bin/
		install -m 755 tools/trust_merger /usr/local/bin/
		improved_git rev-parse @ 2>/dev/null >.commit_id
	fi
}
