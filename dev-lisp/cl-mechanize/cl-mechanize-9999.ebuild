# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit common-lisp-3 git-2

DESCRIPTION="A WWW::Mechanize work-alike library for Common Lisp."
HOMEPAGE="https://github.com/joachifm/cl-mechanize"
SRC_URI=""

EGIT_REPO_URI="https://github.com/joachifm/cl-mechanize.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
dev-lisp/puri
dev-lisp/drakma
dev-lisp/closure-html
dev-lisp/cxml-stp
dev-lisp/cl-ppcre"

