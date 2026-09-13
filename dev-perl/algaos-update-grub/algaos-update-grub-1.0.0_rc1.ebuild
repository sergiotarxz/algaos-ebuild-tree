# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="sergiotarxz"
inherit perl-module desktop git-r3 xdg-utils

HOMEPAGE="https://github.com/sergiotarxz/algaos-update-grub"
EGIT_REPO_URI="https://github.com/sergiotarxz/algaos-update-grub"
EGIT_COMMIT="v${PV/_rc/-rc}"
SRC_URI=""
KEYWORDS="amd64"

DESCRIPTION="AlgaOS update grub utility"

LICENSE="AGPL-3+"
SLOT="0"

RDEPEND="
	dev-lang/perl
	dev-perl/Crypt-URandom
	dev-perl/Moo
	dev-perl/PBKDF2-Tiny
"

DEPEND="${RDEPEND}"
BDEPEND="
	dev-perl/Module-Build
"

src_install() {
	perl-module_src_install
	dobin scripts/update-grub
}

