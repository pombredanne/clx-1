# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit common-lisp-3 git-2

DESCRIPTION="Simple 2d and 3d vector and matrix math library"
HOMEPAGE="https://github.com/anwyn/vecmath"
SRC_URI=""

EGIT_REPO_URI="https://github.com/anwyn/vecmath.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
dev-lisp/alexandria"

