# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit common-lisp-3 git-2

DESCRIPTION="A future roguelike game made in Common Lisp"
HOMEPAGE="https://github.com/gpadd/cl-h12rl"
SRC_URI=""

EGIT_REPO_URI="https://github.com/gpadd/cl-h12rl.git"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
dev-lisp/blocky"

