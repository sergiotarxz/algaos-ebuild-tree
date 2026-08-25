EAPI=8

DESCRIPTION="AlgaOS GNOME Theme"
HOMEPAGE="https://algaos.com"
SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="amd64"

S="${WORKDIR}"

RDEPEND="
	gnome-base/gsettings-desktop-schemas
"

src_install() {
	# Wallpapers
	insinto /usr/share/backgrounds/algaos
	newins "${FILESDIR}/background-algaos-complex.png" \
		light-complex.png
	newins "${FILESDIR}/background-algaos-dark-complex.png" \
		dark-complex.png

	# GNOME wallpaper chooser
	insinto /usr/share/gnome-background-properties
	newins "${FILESDIR}/algaos-wallpaper.xml" \
		algaos-wallpaper.xml

	# AlgaOS vendor defaults
	insinto /usr/share/glib-2.0/schemas
	newins "${FILESDIR}/10-algaos-wallpaper.gschema.override" \
		10_algaos-wallpaper.gschema.override
	insinto /usr/share/pixmaps
	doins "${FILESDIR}/algaos-gdm-logo.png"
}

pkg_postinst() {
	# Rebuild the compiled GSettings schema database.
	glib-compile-schemas /usr/share/glib-2.0/schemas || die

	elog "AlgaOS GNOME wallpaper installed."
}
