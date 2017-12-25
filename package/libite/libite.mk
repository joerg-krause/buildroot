################################################################################
#
# libite
#
################################################################################

LIBITE_VERSION = 2.0.1
LIBITE_SOURCE = libite-$(LIBITE_VERSION).tar.xz
LIBITE_SITE = https://github.com/troglobit/libite/releases/download/v$(LIBITE_VERSION)
LIBITE_LICENSE = MIT, X11, ISC, BSD-2-Clause
LIBITE_LICENSE_FILES = LICENSE chomp.c pidfile.c
LIBITE_INSTALL_STAGING = YES

$(eval $(autotools-package))
