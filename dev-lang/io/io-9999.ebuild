# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit cmake-utils git-2 elisp-common

DESCRIPTION="Io is a small, prototype-based programming language."
HOMEPAGE="http://www.iolanguage.com"
SRC_URI=""
EGIT_REPO_URI="https://github.com/stevedekorte/io.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cgi clutter dbi doc editline emacs google gui http image jabber libffi libxml2 lzo md5sum ogg opengl postgres pcre python readline sha1 sndfile sockets sqlite3 syslog theora threads truetype twitter vim-syntax vorbis zlib"

DEPEND="clutter? ( media-libs/clutter )
dbi? ( dev-db/libdbi )
editline? ( dev-libs/libedit )
image? ( virtual/jpeg
media-libs/tiff
media-libs/libpng )
jabber? ( net-libs/loudmouth )
libffi? ( virtual/libffi )
libxml2? ( dev-libs/libxml2 )
lzo? ( dev-libs/lzo )
ogg? ( media-libs/libogg )
opengl? ( virtual/opengl )
pcre? ( dev-libs/libpcre )
postgres? ( dev-db/postgresql-server )
readline? ( sys-libs/readline )
sndfile? ( media-libs/libsndfile )
sqlite3? ( >=dev-db/sqlite-3.0.0 )
theora? ( media-libs/libtheora )
truetype? ( media-libs/freetype )
vorbis? ( media-libs/libvorbis )
zlib? ( sys-libs/zlib )"
RDEPEND="vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
emacs? ( virtual/emacs )"
REQUIRED_USE="vorbis? ( ogg )"

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo-fixes.patch"
	sed -i -e "2s/\"[0-9]*\"/\"`date +%Y%m%d`\"/" libs/iovm/source/IoVersion.h
}

src_configure() {
	local mycmakeargs=(
	$(cmake-utils_use_enable cgi CGI)
	$(cmake-utils_use_enable clutter CLUTTER)
	$(cmake-utils_use_enable dbi DBI)
	$(cmake-utils_use_enable editline EDITLINE)
	$(cmake-utils_use_enable libffi CFFI)
	$(cmake-utils_use_enable gui FLUX)
	$(cmake-utils_use_enable google GOOGLESEARCH)
	$(cmake-utils_use_enable http HTTPCLIENT)
	$(cmake-utils_use_enable jabber LOUDMOUTH)
	$(cmake-utils_use_enable image IMAGE)
	$(cmake-utils_use_enable libxml2 LIBXML2)
	$(cmake-utils_use_enable lzo LZO)
	$(cmake-utils_use_enable md5sum MD5SUM)
	$(cmake-utils_use_enable ncurses CURSES)
	$(cmake-utils_use_enable ogg OGG)
	$(cmake-utils_use_enable opengl OPENGL)
	$(cmake-utils_use_enable postgres POSTGRESQL)
	$(cmake-utils_use_enable python PYTHON)
	$(cmake-utils_use_enable readline READLINE)
	$(cmake-utils_use_enable pcre REGEX)
	$(cmake-utils_use_enable sndfile LIBSNDFILE)
	$(cmake-utils_use_enable sha1 SHA1)
	$(cmake-utils_use_enable sockets SOCKET)
	$(cmake-utils_use_enable sqlite3 SQLITE3)
	$(cmake-utils_use_enable syslog SYSLOG)
	$(cmake-utils_use_enable theora THEORA)
	$(cmake-utils_use_enable threads THREADS)
	$(cmake-utils_use_enable truetype FONT)
	$(cmake-utils_use_enable twitter TWITTER )
	$(cmake-utils_use_enable vorbis VORBIS)
	$(cmake-utils_use_enable zlib ZLIB)
	-DCMAKE_SKIP_RPATH=ON
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install
	if use doc; then
		dodoc docs/docs.css docs/*.html
	fi

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax/
		doins  extras/SyntaxHighlighters/Vim/io.vim
		exeinto /usr/share/vim/vimfiles/syntax/
	fi

	if use emacs; then
		elisp-install ${PN} extras/SyntaxHighlighters/Emacs/*.el
	fi

}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
	fi

}

pkg_postrm() {
	if use emacs; then
		elisp-site-regen
	fi
}
