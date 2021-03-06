# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SSLeay/Crypt-SSLeay-0.720.0.ebuild,v 1.2 2015/05/03 17:39:20 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=NANIS
MODULE_VERSION=0.72
inherit perl-module

DESCRIPTION="OpenSSL support for LWP"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~x86 ~ppc-aix ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-libs/openssl-0.9.7c:0
	virtual/perl-MIME-Base64
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	>=virtual/perl-ExtUtils-CBuilder-0.280.205
	virtual/perl-Getopt-Long
	>=dev-perl/Path-Class-0.260.0
	>=dev-perl/Try-Tiny-0.190.0
	test? (
		>=virtual/perl-Test-Simple-0.190.0
	)
"
# PDEPEND: circular dependencies bug #144761
PDEPEND="
	dev-perl/libwww-perl
	>=dev-perl/LWP-Protocol-https-6.20.0
"

export OPTIMIZE="${CFLAGS}"
#myconf="--lib=${EPREFIX}/usr"

SRC_TEST=do
