# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Formatted text output"
HOMEPAGE="https://github.com/gigamonkey/monkeylib-text-output/"
SRC_URI=""

EGIT_REPO_URI="https://github.com/gigamonkey/monkeylib-text-output.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
dev-lisp/monkeylib-macro-utilities
dev-lisp/monkeylib-test-framework
dev-lisp/monkeylib-pathnames
dev-lisp/monkeylib-utilities"

