# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2 autotools

DESCRIPTION="iPhone USB Ethernet Driver for Linux pairing helper"
HOMEPAGE="http://giagio.com/wiki/moin.cgi/iPhoneEthernetDriver"
EGIT_REPO_URI="git://github.com/dgiagio/ipheth.git/"
EGIT_PROJECT="ipheth"

EGIT_PATCHES="${FILESDIR}/Makefile.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-pda/libimobiledevice"
RDEPEND="${DEPEND} =app-pda/ipheth-9999"

src_compile() {
	emake -C "${S}/ipheth-pair" || die "emake failed"
}

src_install() {
	emake -C "${S}/ipheth-pair" DESTDIR="${D}" install || die "emake install failed"
}

src_postinstall() {
	/sbin/udevadm control --reload-rules
}
