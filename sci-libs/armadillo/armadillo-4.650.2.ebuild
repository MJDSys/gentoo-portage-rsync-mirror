# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/armadillo/armadillo-4.650.2.ebuild,v 1.2 2015/05/04 13:57:42 jlec Exp $

EAPI=5

CMAKE_IN_SOURCE_BUILD=1

inherit cmake-utils toolchain-funcs multilib eutils

DESCRIPTION="Streamlined C++ linear algebra library"
HOMEPAGE="http://arma.sourceforge.net/"
SRC_URI="mirror://sourceforge/arma/${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0/4"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="arpack blas debug doc examples hdf5 lapack mkl tbb test"
REQUIRED_USE="test? ( lapack )"

RDEPEND="
	dev-libs/boost
	arpack? ( sci-libs/arpack )
	blas? ( virtual/blas )
	lapack? ( virtual/lapack )"
DEPEND="${RDEPEND}
	arpack? ( virtual/pkgconfig )
	blas? ( virtual/pkgconfig )
	hdf5? ( sci-libs/hdf5 )
	lapack? ( virtual/pkgconfig )
	mkl? ( sci-libs/mkl )
	tbb? ( dev-cpp/tbb )"
PDEPEND="${RDEPEND}
	hdf5? ( sci-libs/hdf5 )
	mkl? ( sci-libs/mkl )
	tbb? ( dev-cpp/tbb )"

src_prepare() {
	# avoid the automagic cmake macros
	sed -i -e '/ARMA_Find/d' CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DINSTALL_LIB_DIR="${EPREFIX}/usr/$(get_libdir)"
		$(cmake-utils_use debug ARMA_EXTRA_DEBUG)
		$(cmake-utils_use mkl ARMA_USE_MKL_ALLOC)
		$(cmake-utils_use tbb ARMA_USE_TBB_ALLOC)
	)
	if use arpack; then
		mycmakeargs+=(
			-DARPACK_FOUND=ON
			-DARPACK_LIBRARY="$($(tc-getPKG_CONFIG) --libs arpack)"
		)
	fi
	if use blas; then
		mycmakeargs+=(
			-DBLAS_FOUND=ON
			-DBLAS_LIBRARIES="$($(tc-getPKG_CONFIG) --libs blas)"
		)
	fi
	if use hdf5; then
		mycmakeargs+=(
			-DHDF5_FOUND=ON
			-DHDF5_LIBRARIES="-lhdf5"
		)
	fi
	if use lapack; then
		mycmakeargs+=(
			-DLAPACK_FOUND=ON
			-DLAPACK_LIBRARIES="$($(tc-getPKG_CONFIG) --libs lapack)"
		)
	fi
	cmake-utils_src_configure
}

src_test() {
	pushd examples > /dev/null
	emake \
		CXXFLAGS="-I../include ${CXXFLAGS} -DARMA_USE_BLAS -DARMA_USE_LAPACK" \
		EXTRA_LIB_FLAGS="-L.. $($(tc-getPKG_CONFIG) --libs blas lapack)"
	LD_LIBRARY_PATH="..:${LD_LIBRARY_PATH}" ./example1 || die
	LD_LIBRARY_PATH="..:${LD_LIBRARY_PATH}" ./example2 || die
	emake clean
	popd > /dev/null
}

src_install() {
	cmake-utils_src_install
	dodoc README.txt
	use doc && dodoc *pdf && dohtml *html
	if use examples; then
		insinto /usr/share/examples/${PF}
		doins -r examples/*
	fi
}
