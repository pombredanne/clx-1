# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit common-lisp-2 git vcs-snapshot

DESCRIPTION="OpenCV bindings for SBCL"
HOMEPAGE="https://github.com/longlene/cl-opencv"
#SRC_URI="https://github.com/ryepup/cl-opencv/tarball/master -> ${P}.tar.gz"
SRC_URI="https://github.com/longlene/cl-opencv/tarball/master -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
dev-lisp/cffi
dev-lisp/sbcl
media-libs/opencv
virtual/libffi"

src_compile() {
	emake ||  die "Make failed!"
}
src_install() {
	#emake install || die "Install failed"
	dolib.so build/libcl-opencv-glue.so
	common-lisp-install *.lisp ${PN}.asd
	common-lisp-symlink-asdf
	dodoc README.md LICENSE
}

