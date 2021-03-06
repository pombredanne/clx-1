# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit common-lisp-3 git-2

DESCRIPTION="win32 ole library for common lisp"
HOMEPAGE="https://github.com/quek/cl-win32ole"
SRC_URI=""

EGIT_REPO_URI="https://github.com/quek/cl-win32ole.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
dev-lisp/cffi
dev-lisp/cl-ppcre
dev-lisp/trivial-garbage
dev-lisp/simple-date-time"

src_prepare() {
	rm Makefile
}

