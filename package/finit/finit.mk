################################################################################
#
# finit
#
################################################################################

FINIT_VERSION = 3d4e3c99ed14f07246daa21d14d62c2c0911ea25
FINIT_SITE = $(call github,troglobit,finit,$(FINIT_VERSION))
FINIT_DEPENDENCIES = libite libuev
FINIT_AUTORECONF = YES

FINIT_CONF_OPTS = \
	--enable-fallback-shell \
	$(if $(BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW),--enable-rw-rootfs) \
	$(if $(BR2_PACKAGE_DBUS),--enable-dbus)

$(eval $(autotools-package))

