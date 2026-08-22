EAPI=8

DESCRIPTION="AlgaOS GNOME Theme"
HOMEPAGE="https://algaos.com"
SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="amd64"

RDEPEND="
	gnome-base/gsettings-desktop-schemas
	dev-libs/glib
"

src_install() {
	# Wallpaper images
	insinto /usr/share/backgrounds/algaos
	newins "${FILESDIR}/background-algaos-complex.png" light-complex.png
	newins "${FILESDIR}/background-algaos-dark-complex.png" dark-complex.png

	# GSettings default override
	insinto /usr/share/glib-2.0/schemas
	doins "${FILESDIR}/10-algaos-wallpaper.gschema.override"
}

pkg_postinst() {
	elog "The custom GNOME AlgaOS theme has been installed."
	elog "Log out and back in for the new default to be picked up."
}
