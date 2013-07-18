check_repo() {
yum repolist all 2>&1 | cut -d\  -f1 | cut -d/ -f1 | grep -ix "${1%.repo}" > /dev/null 2>&1
}

config_repo() {
repouri="$1"
repofile=${repouri##*/}
show_msg "Adding $repofile"
check_repo "$repofile"
if [[ $? -eq 0 ]]; then
	show_status "$repofile already configured"
else
	yum-config-manager --add-repo="$repouri"
	exit_state
fi
}

add_repo() {
while [[ $# -gt 0 ]]; do
	if [[ $1 =~ .repo$ ]]; then
		repofile="$1"
		show_msg "Adding $repofile"
		check_repo "$repofile"
		if [[ $? -eq 0 ]]; then
			show_status "$repofile already configured"
		else
			eval "$repofile"
		fi
	fi
	shift
done
}

rpmfusion-free.repo() {
install_local http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${fver}.noarch.rpm
}

rpmfusion-nonfree.repo() {
install_local http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${fver}.noarch.rpm
}

livna.repo() {
install_local http://rpm.livna.org/livna-release.rpm http://ftp-stud.fht-esslingen.de/pub/Mirrors/rpm.livna.org/livna-release.rpm
# Disable Livna repo
sed -i 's/enabled=.*$/enabled=0/g' "/etc/yum.repos.d/livna.repo"
}

bumblebee.repo() {
install_local http://install.linux.ncsu.edu/pub/yum/itecs/public/bumblebee-nonfree/fedora${fver}/noarch/bumblebee-nonfree-release-1.0-1.noarch.rpm
}

adobe-linux-i386.repo() {
install_local http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
}

adobe-linux-x86_64.repo() {
install_local http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
}

rpmsphere.repo() {
install_local http://download.opensuse.org/repositories/home:/zhonghuaren/Fedora_19/noarch/rpmsphere-release-18.17-2.1.noarch.rpm
}

google.repo() {
rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub
cat <<EOF | tee /etc/yum.repos.d/google.repo > /dev/null 2>&1
[Google]
name=Google - $(uname -i)
baseurl=http://dl.google.com/linux/rpm/stable/$(uname -i)
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
enabled=1
gpgcheck=1
skip_if_unavailable=1
EOF
}

skype.repo() {
cat <<EOF | tee /etc/yum.repos.d/skype.repo > /dev/null 2>&1
[skype]
name=Skype Repository
baseurl=http://download.skype.com/linux/repos/fedora/updates/i586/
gpgkey=http://www.skype.com/products/skype/linux/rpm-public-key.asc
enabled=1
gpgcheck=1
skip_if_unavailable=1
EOF
}

steam.repo() {
cat <<EOF | tee /etc/yum.repos.d/steam.repo > /dev/null 2>&1
[steam]
name=Steam RPM packages and dependencies
baseurl=http://spot.fedorapeople.org/steam/fedora-\$releasever/
enabled=1
gpgcheck=0
skip_if_unavailable=1
EOF
}

elegance-colors.repo() {
cat <<EOF | tee /etc/yum.repos.d/elegance-colors.repo > /dev/null 2>&1
[elegance-colors]
name=Elegance Colors Gnome Shell theme
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/elegance-colors/Fedora_\$releasever/
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/elegance-colors/Fedora_\$releasever/repodata/repomd.xml.key
gpgcheck=1
enabled=1
skip_if_unavailable=1
EOF
}

gtk-theme-config.repo() {
cat <<EOF | tee /etc/yum.repos.d/gtk-theme-config.repo > /dev/null 2>&1
[gtk-theme-config]
name=GTK theme preferences
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/gtk-theme-config/Fedora_\$releasever/
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/gtk-theme-config/Fedora_\$releasever/repodata/repomd.xml.key
gpgcheck=1
enabled=1
skip_if_unavailable=1
EOF
}

fedorautils.repo() {
cat <<EOF | tee /etc/yum.repos.d/fedorautils.repo > /dev/null 2>&1
[fedorautils]
name=Fedora Utils
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_\$releasever/
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_\$releasever/repodata/repomd.xml.key
gpgcheck=1
enabled=1
metadata_expire=1d
skip_if_unavailable=1
EOF
}
