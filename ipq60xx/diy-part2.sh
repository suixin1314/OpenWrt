#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config


# 移除要替换的包
rm -rf feeds/packages/net/msd_lite
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-serverchan
rm -rf feeds/packages/mqttled
rm -rf feeds/packages/shadow


#rust编译问题
sed -i 's/--set=llvm\.download-ci-llvm=true/--set=llvm.download-ci-llvm=false/' feeds/packages/lang/rust/Makefile
# 修复 mqttled 依赖
sed -i 's/python3-netifaces/netifaces-python3/' \
  package/feeds/packages/mqttled/Makefile

# 修复 shadow 依赖
sed -i 's/libxcrypt/libxcrypt-full/' \
  package/feeds/packages/shadow/Makefile

# 添加 libxcrypt-full 依赖声明
sed -i '/define Package\/shadow\/install/i \	+libxcrypt-full \\' \
  package/feeds/packages/shadow/Makefile
  
cat >> .config << 'EOF'
CONFIG_PACKAGE_netifaces-python3=y
CONFIG_PACKAGE_libxcrypt-full=y
CONFIG_PACKAGE_python3-paho-mqtt=y
CONFIG_PACKAGE_libmosquitto-ssl=y
EOF



