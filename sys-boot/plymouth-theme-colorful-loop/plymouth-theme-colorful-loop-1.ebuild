EAPI=8

DESCRIPTION="Colorful Loop Plymouth theme"
HOMEPAGE="https://github.com/adi1090x/plymouth-themes"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="sys-boot/plymouth"

S="${WORKDIR}"

src_unpack() {
	unpack "${FILESDIR}/colorful.tar.gz"
}

src_install() {
	insinto /usr/share/plymouth/themes/colorful_loop
	doins "${S}/colorful_loop/"*
}
