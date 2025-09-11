#!/bin/bash

#安装和更新软件包
UPDATE_PACKAGE() {
	local PKG_NAME=$1
	local PKG_REPO=$2
	local PKG_BRANCH=$3
	local PKG_SPECIAL=$4
	local REPO_NAME=$(echo $PKG_REPO | cut -d '/' -f 2)

	rm -rf $(find ./ ../feeds/luci/ ../feeds/packages/ -maxdepth 3 -type d -iname "*$PKG_NAME*" -prune)
        find ./ | grep Makefile | grep $PKG_NAME | xargs rm -f

	git clone --depth=1 --single-branch --branch $PKG_BRANCH "https://github.com/$PKG_REPO.git"

	if [[ $PKG_SPECIAL == "pkg" ]]; then
		cp -rf $(find ./$REPO_NAME/*/ -maxdepth 3 -type d -iname "*$PKG_NAME*" -prune) ./
                if [[ $PKG_REPO == "immortalwrt/luci" ]]; then
			cp -rf ./$REPO_NAME/luci.mk ../
                fi
		rm -rf ./$REPO_NAME/
	elif [[ $PKG_SPECIAL == "name" ]]; then
		mv -f $REPO_NAME $PKG_NAME
	fi
}

#UPDATE_PACKAGE "包名" "项目地址" "项目分支" "pkg/name，可选，pkg为从大杂烩中单独提取包名插件；name为重命名为包名"
UPDATE_PACKAGE "argon" "jerrykuku/luci-theme-argon" "openwrt-24.10"
UPDATE_PACKAGE "openclash" "vernesong/OpenClash" "master" "pkg"
UPDATE_PACKAGE "mosdns" "sbwml/luci-app-mosdns" "v5"
UPDATE_PACKAGE "v2ray-geodata" "sbwml/v2ray-geodata" "master"
UPDATE_PACKAGE "ddns-go" "sirpdboy/luci-app-ddns-go" "main"


if [[ $WRT_REPO == *"openwrt"* ]] && [[ $WRT_REPO != *"LiBwrt"* ]]; then
	UPDATE_PACKAGE "luci-app-zerotier" "immortalwrt/luci" "master" "pkg"
        UPDATE_PACKAGE "packages_lang_golang" "sbwml/packages_lang_golang" "23.x"
fi
