# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/phex/phex-3.2.0.102.ebuild,v 1.2 2008/01/22 22:09:48 betelgeuse Exp $

EAPI=1

inherit java-pkg-2 java-ant-2

MY_P="${PN}_${PV}"

DESCRIPTION="java gnutella file-sharing application"
HOMEPAGE="http://phex.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}_src.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
COMMON_DEPEND="dev-java/commons-httpclient:3
	dev-java/commons-logging:0
	dev-java/jgoodies-forms:0
	dev-java/jgoodies-looks:2.0
	dev-java/log4j:0
	dev-java/l2fprod-common:0
	dev-java/commons-beanutils:1.7
	dev-java/commons-codec:0
	dev-java/commons-collections:0
	dev-java/commons-lang:2.1"

DEPEND="app-arch/unzip
	>=virtual/jdk-1.5
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"

S="${WORKDIR}/${MY_P}_src"

JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# build macosx gui against the bundled library, but don't install the library
	# easier than to patch the gui out, it won't be executed anyway ...
	mv lib/MRJAdapter.jar .
#	rm -vf lib/*.jar 
	# avoid patches like plague
	sed -i "s/createJar, copyThirdpartyJars/createJar/" build/buildJava.xml
	JAVA_ANT_REWRITE_CLASSPATH="true" java-ant_bsfix_files build/*.xml
	# remove bundled packages that we have - bug #176739
	rm -rf src/com/l2fprod src/org/apache 
}

src_compile() {
	local gcp="$(java-pkg_getjars commons-httpclient-3,commons-logging,jgoodies-forms,jgoodies-looks-2.0,log4j,l2fprod-common,commons-beanutils-1.7,commons-codec,commons-collections,commons-lang-2.1)"
	cd build
	eant -Dgentoo.classpath="${gcp}:MRJAdapter.jar" -Dproject.buildtarget=lib
	Phex
}

src_install() {
	java-pkg_dojar lib/${PN}.jar

	java-pkg_dolauncher ${PN} --main phex.Main

	dohtml docs/readme/* || die
}
