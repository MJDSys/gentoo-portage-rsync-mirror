# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/vboot-utils/vboot-utils-42_p20150219.ebuild,v 1.2 2015/03/23 17:17:36 vapier Exp $

EAPI=5

inherit eutils toolchain-funcs

# This is the latest commit in the latest branch.
GIT_SHA1="f44ebbe36b2c1603437edc57b534244e89bfcd9c"

DESCRIPTION="Chrome OS verified boot tools"
HOMEPAGE="https://chromium.googlesource.com/chromiumos/platform/vboot_reference/ http://dev.chromium.org/chromium-os/chromiumos-design-docs/verified-boot"
# Can't use gitiles directly until b/19710536 is fixed.
#SRC_URI="https://chromium.googlesource.com/chromiumos/platform/vboot_reference/+archive/${GIT_SHA1}.tar.gz -> ${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86"
IUSE="minimal static"

RDEPEND="dev-libs/openssl:0=
	sys-apps/util-linux:=
	!minimal? (
		app-arch/xz-utils:=
		dev-libs/libyaml:=
	)"
DEPEND="${RDEPEND}
	app-crypt/trousers"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-cgpt-static.patch
	sed -i \
		-e 's: -Werror : :g' \
		Makefile || die
}

_emake() {
	local arch=$(tc-arch)
	emake \
		V=1 \
		QEMU_ARCH= \
		ARCH=${arch} \
		HOST_ARCH=${arch} \
		LIBDIR="$(get_libdir)" \
		DEBUG_FLAGS= \
		MINIMAL=$(usev minimal) \
		STATIC=$(usev static) \
		"$@"
}

src_compile() {
	tc-export CC AR CXX PKG_CONFIG
	_emake TEST_BINS= all
}

src_test() {
	_emake runtests
}

src_install() {
	_emake DESTDIR="${ED}/usr" install
	if ! use minimal ; then
		rm -r "${ED}"/usr/default || die
	fi

	insinto /usr/share/vboot/devkeys
	doins tests/devkeys/*

	insinto /usr/include/vboot
	doins host/include/* \
		firmware/include/gpt.h \
		firmware/include/tlcl.h \
		firmware/include/tss_constants.h

	dolib.a build/libvboot_host.a

	dodoc README
}
