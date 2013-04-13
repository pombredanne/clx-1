# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Common Lisp bindings for the OpenAL audio library"
HOMEPAGE="https://github.com/sykopomp/cl-openal"
SRC_URI="https://github.com/sykopomp/cl-openal/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
media-libs/openal
dev-lisp/cffi"
