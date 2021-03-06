# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shelltestrunner/shelltestrunner-1.3.4.ebuild,v 1.1 2015/03/05 22:57:06 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.4.9999

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="A tool for testing command-line programs"
HOMEPAGE="http://joyful.com/shelltestrunner"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
	>=dev-haskell/cmdargs-0.7 <dev-haskell/cmdargs-0.11
	>=dev-haskell/diff-0.2.0 <dev-haskell/diff-0.4
	>=dev-haskell/filemanip-0.3 <dev-haskell/filemanip-0.4
	<dev-haskell/hunit-1.3
	<dev-haskell/parsec-3.2
	>=dev-haskell/regex-tdfa-1.1 <dev-haskell/regex-tdfa-1.3
	>=dev-haskell/test-framework-0.3.2 <dev-haskell/test-framework-0.9
	>=dev-haskell/test-framework-hunit-0.2 <dev-haskell/test-framework-hunit-0.4
	>=dev-haskell/utf8-string-0.3.5 <dev-haskell/utf8-string-0.4
	>=dev-lang/ghc-7.4.1
"
