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

sed -i 's/--set=llvm\.download-ci-llvm=true/--set=llvm.download-ci-llvm=false/' feeds/packages/lang/rust/Makefile
