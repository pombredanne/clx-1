# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit common-lisp-3 git-2

DESCRIPTION="Markdown for Common Lisp"
HOMEPAGE="https://github.com/orthecreedence/markdown.cl"
SRC_URI=""

EGIT_REPO_URI="https://github.com/orthecreedence/markdown.cl.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
dev-lisp/xmls
dev-lisp/cl-ppcre"

CLPACKAGE="markdown.cl"
