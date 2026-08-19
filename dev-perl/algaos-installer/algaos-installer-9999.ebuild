# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="sergiotarxz"
inherit perl-module desktop git-r3
HOMEPAGE="https://github.com/sergiotarxz/algaos-installer"
EGIT_REPO_URI="https://github.com/sergiotarxz/algaos-installer"
SRC_URI=""

DESCRIPTION="AlgaOS Installer"

LICENSE="AGPLv3"
SLOT="0"

RDEPEND="
	dev-lang/perl
	dev-perl/ExtUtils-CBuilder
	dev-perl/Crypt-URandom
	dev-perl/Moo
	dev-perl/PBKDF2-Tiny
	dev-perl/JSON
	dev-perl/Module-Build
	gui-libs/gtk:4
"
DEPEND="${RDEPEND}"

src_install() {
	perl-module_src_install
	dobin scripts/algaos-installer
	domenu com.algaos.Installer.desktop
	insinto /etc/xdg/autostart
	doins com.algaos.Installer.desktop
	newicon -s scalable algaos-installer-logo.svg algaos-installer-logo.svg
}
