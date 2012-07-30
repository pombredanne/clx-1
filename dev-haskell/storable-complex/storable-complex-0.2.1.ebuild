# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="A Storable instance for Complex that is compatible with C99, C++ and Fortran complex data types."
HOMEPAGE="http://hackage.haskell.org/package/storable-complex"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.12"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
