# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit common-lisp-3 git-2

DESCRIPTION="libevent2 bindings for Common Lisp "
HOMEPAGE="https://github.com/sykopomp/cl-event2"
SRC_URI=""

EGIT_REPO_URI="https://github.com/sykopomp/cl-event2.git"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
!dev-lisp/cl-libevent2
dev-libs/libevent
dev-lisp/cffi
dev-lisp/trivial-garbage"

