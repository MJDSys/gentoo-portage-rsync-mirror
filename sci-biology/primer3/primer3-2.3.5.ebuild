# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/primer3/primer3-2.3.5.ebuild,v 1.4 2015/04/21 19:22:54 pacho Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Primer Design for PCR reactions"
HOMEPAGE="http://primer3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"

DEPEND="dev-lang/perl"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.3.4-buildsystem.patch

	if [[ ${CHOST} == *-darwin* ]]; then
		sed -e "s:LIBOPTS ='-static':LIBOPTS =:" -i Makefile || die
	fi

	tc-export CC CXX AR RANLIB
}

src_compile() {
	emake -C src
}

src_test () {
	emake -C test | tee "${T}"/test.log
	grep -q "\[FAILED\]" && die "test failed. See "${T}"/test.log"
}

src_install () {
	dobin src/{long_seq_tm_test,ntdpal,oligotm,primer3_core}
	dodoc src/release_notes.txt example
	insinto /opt/primer3_config
	doins -r src/primer3_config/* primer3*settings.txt
	dohtml primer3_manual.htm
}
