# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/dswm/dswm-0.0.3.ebuild,v 1.2 2011/04/25 20:36:20 betelgeuse Exp $

EAPI="2"

inherit common-lisp autotools eutils

DESCRIPTION="Stumpwm is a tiling, keyboard driven X11 Window Manager written entirely in Common Lisp."
# HOMEPAGE="http://www.nongnu.org/stumpwm/index.html"
# SRC_URI="http://download.savannah.nongnu.org/releases/stumpwm/${P}.tgz"
SRC_URI="http://sourceforge.net/projects/dswm/files/0.0.3-git/${P}-git.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="emacs doc"

CLPACKAGE="dswm"

DEPEND="dev-lisp/common-lisp-controller
	=dev-lisp/sbcl-1.0.36-r1
	dev-lisp/cl-clx
	dev-lisp/cl-ppcre
	doc? ( sys-apps/texinfo )"

RDEPEND="x11-base/xorg-server
	emacs? ( app-emacs/slime )"

src_prepare() {
	mv ${P}-git/* .
	rm -rf ${P}-git/
	eautoconf
}

src_configure() {
	## sed "s,@PACKAGE_VERSION@,$PV,g" version.lisp.in > version.lisp
	## autocnof
	##./configure --prefix=/usr --with-lisp=sbcl || die
	# autoconf
        econf \
	--prefix=/usr --with-lisp=sbcl ${myconf}
}

src_compile() {
	emake
	use doc && makeinfo dswm.texi
}

src_install() {
	common-lisp-install *.lisp dswm.asd
	common-lisp-system-symlink
	emake destdir=${D} install
	dodoc README NEWS ChangeLog "${FILESDIR}/README.Gentoo" || die
	use doc && doinfo dswm.info
}

pkg_postinst() {
	common-lisp_pkg_postinst
	cat "${FILESDIR}/README.Gentoo"
}
