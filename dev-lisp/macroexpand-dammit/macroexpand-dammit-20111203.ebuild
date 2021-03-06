# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit common-lisp-3

DESCRIPTION="portable macroexpander for Common Lisp"
HOMEPAGE="http://john.freml.in/macroexpand-dammit"
SRC_URI="http://beta.quicklisp.org/archive/macroexpand-dammit/2011-12-03/macroexpand-dammit-20111203-http.tgz -> ${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${P}-http
