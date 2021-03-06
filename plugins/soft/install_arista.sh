# Name: Install Arista Transcoder
# Command: install_arista

install_arista() {
show_func "Installing Arista Transcoder"
if [[ "$(install_arista_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
	show_status "Arista Transcoder already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
	show_msg "Installing dependencies..."
	install_pkg cairo dbus-python gnome-python2-gconf gnome-python2-rsvg gstreamer-ffmpeg gstreamer-plugins-bad gstreamer-plugins-bad-nonfree gstreamer-plugins-base gstreamer-plugins-good gstreamer-plugins-ugly gstreamer-python nautilus-python notify-python pygtk2 python python2-devel python3-devel python3-gobject python-gudev python-simplejson
	show_msg "Fetching webpage..."
	get_file_quiet "https://github.com/danielgtaylor/arista/tags.atom" "tags.atom"
	aristaver=$(grep "<title>.*</title>" "tags.atom" | grep -o "[0-9].[0-9].[0-9]" | head -n 1)
	get="https://github.com/danielgtaylor/arista/archive/${aristaver}.tar.gz"
	file=${get##*/}
	get_file
	tar -xvf "$file"
	cd arista-*
	python setup.py build
	python setup.py install
fi
[[ "$(install_arista_test)" = "Installed" ]]; exit_state
}

install_arista_test() {
if [[ -f /usr/bin/arista-gtk ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
