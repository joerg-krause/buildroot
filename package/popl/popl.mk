################################################################################
#
# popl
#
################################################################################

POPL_VERSION = v0.3.0
POPL_SITE = $(call github,badaix,popl,$(POPL_VERSION))
POPL_LICENSE = MIT
POPL_LICENSE_FILES = LICENSE

# Only installs headers
POPL_INSTALL_TARGET = NO
POPL_INSTALL_STAGING = YES

define POPL_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/include/popl.hpp \
		$(STAGING_DIR)/usr/include/popl.hpp
endef

$(eval $(generic-package))
