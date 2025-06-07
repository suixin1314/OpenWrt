##!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo " " >> feeds.conf.default
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> feeds.conf.default
#echo 'src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git' >> feeds.conf.default
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages.git' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small.git' >> feeds.conf.default
#echo 'src-git modemfeed https://github.com/koshev-msk/modemfeed.git' >> feeds.conf.default
#echo 'src-git UA3F https://github.com/SunBK201/UA3F.git' >> feeds.conf.default
echo 'src-git OpenClash https://github.com/vernesong/OpenClash.git' >> feeds.conf.default
#echo 'src-git qmodem https://github.com/FUjr/QModem.git' >> feeds.conf.default

#添加passwall的包
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall

rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

rm -rf feeds/packages/net/msd_lite
rm -rf package/feeds/luci/luci-app-msd_lite
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-serverchan

# msd_lite
git clone --depth=1 https://github.com/ximiTech/luci-app-msd_lite package/luci-app-msd_lite
git clone --depth=1 https://github.com/ximiTech/msd_lite package/msd_lite

mkdir -p package/custom/python-netifaces

# 创建 Makefile
cat > package/custom/python-netifaces/Makefile << 'EOF'
include $(TOPDIR)/rules.mk

PKG_NAME:=python3-netifaces
PKG_VERSION:=0.11.0
PKG_RELEASE:=1

PYPI_NAME:=netifaces
PKG_HASH:=0de901e592b77b863443f345c7d81a0c8fb3e7dacfcc3caa0f3a9c1e1a8d8d1e

include $(INCLUDE_DIR)/../feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/../feeds/packages/lang/python/python3-package.mk

define Package/python3-netifaces
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Portable network interface information
  URL:=https://pypi.org/project/netifaces/
  DEPENDS:=+python3
endef

define Package/python3-netifaces/description
Portable access to network interfaces from Python
endef

$(eval $(call Py3Package,python3-netifaces))
$(eval $(call BuildPackage,python3-netifaces))
EOF
