# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ircd/selinux-ircd-2.20141203-r5.ebuild,v 1.1 2015/04/15 15:43:25 perfinion Exp $
EAPI="5"

IUSE=""
MODS="ircd"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for ircd"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
