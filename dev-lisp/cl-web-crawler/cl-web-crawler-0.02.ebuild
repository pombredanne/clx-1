# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit common-lisp-3

DESCRIPTION="A web-crawling library for Common Lisp"
HOMEPAGE="https://code.google.com/p/cl-web-crawler/"
SRC_URI="https://cl-web-crawler.googlecode.com/files/cl-web-crawler_0.02.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
dev-lisp/drakma
dev-lisp/puri
dev-lisp/cl-ppcre
dev-lisp/cl-html-parse"

