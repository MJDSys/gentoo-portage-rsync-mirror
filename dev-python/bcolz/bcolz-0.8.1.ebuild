# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bcolz/bcolz-0.8.1.ebuild,v 1.1 2015/03/01 14:39:41 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Provides columnar and compressed data containers"
HOMEPAGE=" https://github.com/Blosc/bcolz"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

# numexpr is optional but set hard rdeoend
RDEPEND=">=dev-python/numpy-1.7[${PYTHON_USEDEP}]
	>=dev-python/numexpr-1.4.1[${PYTHON_USEDEP}]"
DEPEND=">=dev-python/cython-0.22[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_prepare_all() {
	if use doc; then
		mkdir doc/_static || die
	fi
	distutils-r1_python_prepare_all
}

python_compile() {
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
	distutils-r1_python_compile
}

python_compile_all() {
	use doc && sphinx-build -b html -c doc/ doc/ doc/html
}

python_test() {
	pushd "${BUILD_DIR}"/lib > /dev/null
	"${PYTHON}" -m unittest discover || die
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/html/. )
	distutils-r1_python_install_all
}
