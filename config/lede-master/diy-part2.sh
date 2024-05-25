/bin/bash #!/bin/bash
#================================================== ================================================== ============================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# 描述：为 Amlogic s9xxx 电视盒自动构建 OpenWrt
#功能：DIY脚本（更新订阅源，修改默认IP，主机名，主题，添加/删除订阅源等）
# 源代码仓库：https://github.com/coolsnowwolf/lede / 分支：master
#===================================================== =================================================== =========================================

# ------------------------------- 主源已启动 --------------- ----------------
#
# 修改默认主题（从 uci-theme-bootstrap 改为 luci-theme-material）
# sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# ADVANTAGE 对 armvirt 的 autocore 支持
sed -i    's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g'包/lean/autocore/Makefile

# 设置 etc/openwrt_release
sed -i   "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R $(date +%Y.%m.%d) '|g"包/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_SOURCECODE='lede'" >>package/base-files/files/etc/openwrt_release

# 修改默认IP（从192.168.1.1改为192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' 包/base-files/files/bin/config_generate

# 恢复默认软件源
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' 包/lean/default-settings/files/zzz-default-settings
#
# ------------------------------- 主源结束 --------------- ----------------

# ------------------------------- 其他已开始 ---------------- ---------------
#
# 添加 luci-app-amlogic
#svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic 包/luci-app-amlogic

# 修复 runc 版本错误
# rm -rf ./feeds/packages/utils/runc/Makefile
# svn 导出 https://github.com/openwrt/packages/trunk/utils/runc/Makefile ./feeds/packages/utils/runc/Makefile

#coolsnowwolf默认球队替换为Lienol相关球队
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

#第三方图片（整个商店）
# git 克隆 https://github.com/libremesh/lime-packages.git 包/lime-packages
#添加第三方图片（指定包）
# svn co https://github.com/libremesh/lime-packages/trunk/packages/{shared-state-pirania,pirania-app,pirania} 包/lime-packages/packages
#添加编译选项（根据第三方库Makefile的要求添加相关依赖）
# sed -i “/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset shared-state-pirania uhttpd-mod-lua/” 目标/linux/armvirt/Makefile

# 应用补丁
# git apply../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- 其他目的 ---------------- ---------------

