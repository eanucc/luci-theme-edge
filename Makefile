#
# Copyright (C) 2008-2019 Jerrykuku
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Edge Theme
LUCI_DEPENDS:=
PKG_VERSION:=1.5
PKG_RELEASE:=20200720


include $(TOPDIR)/feeds/luci/luci.mk

define Package/luci-theme-edge/postinst
#!/bin/sh
	sed -i ":a;$!N;s/\(tmpl\|t\).render.*sysauth_template.*\nduser.*\nfuser.*\n})\nreturn/local scope = { duser = \"root\", fuser = user }\nlocal ok, res = luci.util.copcall\(luci.template.render_string, [[<% include\(\"themes\/\" .. theme .. \"\/sysauth\"\) %>]], scope\)\nif ok then\nreturn res\nend\nreturn luci.template.render\(\"sysauth\", scope\)/;ba" /usr/lib/lua/luci/dispatcher.lua
	rm -Rf /var/luci-modulecache
endef

# call BuildPackage - OpenWrt buildroot signature
