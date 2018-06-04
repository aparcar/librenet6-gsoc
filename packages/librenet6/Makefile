include $(TOPDIR)/rules.mk

PKG_NAME:=librenet6
PKG_VERSION:=0.1
PKG_RELEASE:=0

PKG_MAINTAINER:=Paul Spooren <spooren@informatik.uni-leipzig.de>

include $(INCLUDE_DIR)/package.mk

define Package/librenet6/Default
  SECTION:=lime
  CATEGORY:=LiMe
  TITLE:=librenet6
  PKGARCH:=all
  DEPENDS:=tinc
endef

define Package/librenet6-bmx6
  $(call Package/librenet6/Default)
  TITLE+= bmx6
  DEPENDS:=+bmx6 +lime-proto-bmx6
endef

define Package/librenet6-bmx7
  $(call Package/librenet6/Default)
  TITLE+= bmx7
  DEPENDS:=+bmx7 +lime-proto-bmx7
endef

define Package/librenet6-babeld
  $(call Package/librenet6/Default)
  TITLE+= babeld
  DEPENDS:=+babeld lime-proto-babeld
endef

define Package/librenet6-topu
  $(call Package/librenet6/Default)
  TITLE+= topu server
endef

define Package/librenet6-gsoc
  $(call Package/librenet6/Default)
  TITLE+= gsoc server
endef

Build/Compile=

define Package/librenet6-topu/install
		$(INSTALL_DIR) $(1)/
		$(CP) -r files/topu/* $(1)/
endef

define Package/librenet6-gsoc/install
		$(INSTALL_DIR) $(1)/
		$(CP) -r files/gsoc/* $(1)/
endef

define Package/librenet6-bmx6/install
		$(INSTALL_DIR) $(1)/
		$(CP) -r files/common/* $(1)/
		$(CP) -r files/bmx6/* $(1)/
endef

define Package/librenet6-bmx7/install
		$(INSTALL_DIR) $(1)/
		$(CP) -r files/common/* $(1)/
		$(CP) -r files/bmx7/* $(1)/
endef

define Package/librenet6-babeld/install
		$(INSTALL_DIR) $(1)/
		$(CP) -r files/common/* $(1)/
endef

define Package/librenet6-dnsmasq/install
		$(INSTALL_DIR) $(1)/
		$(CP) -r files/common/* $(1)/
		$(INSTALL_DIR) $(1)/etc/uci-defaults
		$(CP) files/dnsmasq.defaults $(1)/etc/uci-defaults
endef

define Package/librenet6-odhcpd/install
		$(call Package/librenet6/Default/install)
		$(INSTALL_DIR) $(1)/etc/uci-defaults
		$(CP) files/odhcpd.defaults $(1)/etc/uci-defaults
endef

$(eval $(call BuildPackage,librenet6-bmx6))
$(eval $(call BuildPackage,librenet6-bmx7))
$(eval $(call BuildPackage,librenet6-babeld))
$(eval $(call BuildPackage,librenet6-topu))
$(eval $(call BuildPackage,librenet6-gsoc))
