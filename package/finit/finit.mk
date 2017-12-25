################################################################################
#
# finit
#
################################################################################

FINIT_VERSION = 3.1-rc1
FINIT_SOURCE = finit-$(FINIT_VERSION).tar.xz
FINIT_SITE = https://github.com/troglobit/finit/releases/download/$(FINIT_VERSION)
FINIT_LICENSE = MIT
FINIT_LICENSE_FILES = LICENSE

FINIT_DEPENDENCIES = libite libuev host-pkgconf

FINIT_CONF_OPTS = \
	--enable-fallback-shell \
	--enable-progress \
	$(if $(SKELETON_INIT_COMMON_ISSUE),--with-heading="$(SKELETON_INIT_COMMON_ISSUE)") \
	$(if $(SKELETON_INIT_COMMON_HOSTNAME),--with-hostname="$(SKELETON_INIT_COMMON_HOSTNAME)") \
	$(if $(BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW),--enable-rw-rootfs) \
	$(if $(BR2_PACKAGE_ALSA_UTILS),--enable-alsa-utils-plugin) \
	$(if $(BR2_PACKAGE_DBUS),--enable-dbus-plugin)

ifeq ($(BR2_PACKAGE_BUSYBOX),y)
define FINIT_SET_GETTY
	echo "tty /sbin/getty -L $(SYSTEM_GETTY_OPTIONS) $(SYSTEM_GETTY_PORT) $(SYSTEM_GETTY_BAUDRATE) $(SYSTEM_GETTY_TERM)"
endef
else
define FINIT_SET_GETTY
	echo "tty $(SYSTEM_GETTY_PORT) $(SYSTEM_GETTY_BAUDRATE) $(SYSTEM_GETTY_OPTIONS) $(SYSTEM_GETTY_TERM)"
endef
endif # BR2_PACKAGE_BUSYBOX

ifeq ($(BR2_TARGET_GENERIC_GETTY),y)
define FINIT_SET_GENERIC_GETTY
	mkdir -p $(TARGET_DIR)/etc/finit.d/available
	( \
		$(FINIT_SET_GETTY); \
	) > $(TARGET_DIR)/etc/finit.d/available/getty.conf
	( \
		cd $(TARGET_DIR)/etc/finit.d; \
		ln -sf available/getty.conf getty.conf; \
	)
endef
FINIT_TARGET_FINALIZE_HOOKS += FINIT_SET_GENERIC_GETTY
endif # BR2_TARGET_GENERIC_GETTY

$(eval $(autotools-package))
