# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="sergiotarxz"
inherit perl-module desktop git-r3 xdg-utils
HOMEPAGE="https://github.com/sergiotarxz/algaos-updater"
EGIT_REPO_URI="https://github.com/sergiotarxz/algaos-updater"
EGIT_COMMIT="v${PV/_rc/-rc}"
SRC_URI=""
KEYWORDS="amd64"

DESCRIPTION="AlgaOS Updater"

LICENSE="AGPL-3+"
SLOT="0"

RDEPEND="
	dev-lang/perl
	dev-perl/Crypt-URandom
	dev-perl/Moo
	dev-perl/PBKDF2-Tiny
	dev-perl/JSON
	gui-libs/gtk:4
"

DEPEND="${RDEPEND}"
BDEPEND="
	dev-perl/Module-Build
"


src_install() {
	perl-module_src_install
	dobin scripts/algaos-updater
	domenu com.algaos.Updater.desktop
	insinto /etc/xdg/autostart
	doins com.algaos.Updater.desktop
	newicon -s scalable com.algaos.Updater.svg com.algaos.Updater.svg
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
