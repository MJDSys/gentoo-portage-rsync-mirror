# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-pogooglue/lc-pogooglue-0.6.65.ebuild,v 1.1 2014/04/10 18:00:51 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Provides searching with Google to other LeechCraft plugins"

SLOT="0"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

DEPEND="~app-leechcraft/lc-core-${PV}"
RDEPEND="${DEPEND}"
