################################################################################
#
# snapcast
#
################################################################################

SNAPCAST_VERSION = v0.11.0-beta-1
SNAPCAST_SITE = $(call github,badaix,snapcast,$(SNAPCAST_VERSION))
SNAPCAST_LICENSE = GPLv3+
SNAPCAST_LICENSE_FILES = LICENSE
SNAPCAST_DEPENDENCIES = alsa-lib asio avahi flac popl tremor

SNAPCAST_CXXFLAGS = $(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include

define SNAPCAST_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) CXXFLAGS="$(SNAPCAST_CXXFLAGS)" $(MAKE) -C $(@D)/client TARGET=BUILDROOT
endef

define SNAPCAST_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/client/snapclient $(TARGET_DIR)/usr/bin/snapclient
endef

$(eval $(generic-package))
