#!/bin/bash

PKG_PATCH="$GITHUB_WORKSPACE/wrt/package/"

#预置OpenClash内核和数据
if [ -d *"openclash"* ]; then

	if echo "$WRT_TARGET" | grep -Eiq "64|86"; then
	    CORE_TYPE="amd64"
	elif echo "$WRT_TARGET" | grep -Eiq "IPQ807X"; then
	    CORE_TYPE="arm64"
	elif echo "$WRT_TARGET" | grep -Eiq "MT7621"; then
	    CORE_TYPE="mipsle-softfloat"
	else
	    CORE_TYPE="$WRT_TARGET"  # 默认情况下返回WRT_TARGET的值
	fi
 
    #CORE_TYPE=$(echo $WRT_TARGET | grep -Eiq "64|86" && echo "amd64" || echo $WRT_TARGET | grep -Eiq "IPQ807X" && echo "arm64" || echo $WRT_TARGET | grep -Eiq "MT7621" && echo "mipsle-softfloat")
	#CORE_VER="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/core_version"
	#CORE_TUN_VER=$(curl -sL $CORE_VER | sed -n "2{s/\r$//;p;q}")

	CORE_MATE="https://github.com/vernesong/OpenClash/raw/core/master/meta/clash-linux-$CORE_TYPE.tar.gz"
	#CORE_TUN="https://github.com/vernesong/OpenClash/raw/core/master/premium/clash-linux-$CORE_TYPE-$CORE_TUN_VER.gz"
    #CORE_DEV="https://github.com/vernesong/OpenClash/raw/core/master/dev/clash-linux-$CORE_TYPE.tar.gz"

	cd ./luci-app-openclash/root/etc/openclash/
	mkdir ./core/ && cd ./core/
	curl -sL -o meta.tar.gz $CORE_MATE && tar -zxf meta.tar.gz && mv -f clash clash_meta && echo "meta done!"
	#curl -sL -o tun.gz $CORE_TUN && gzip -d tun.gz && mv -f tun clash_tun && echo "tun done!"
	#curl -sL -o dev.tar.gz $CORE_DEV && tar -zxf dev.tar.gz && echo "dev done!"
	chmod +x ./* && rm -rf ./*.gz
    cd $PKG_PATCH && echo "openclash core has been updated!"
	
	GEO_MMDB="https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country-only-cn-private.mmdb"
	GEO_SITE="https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat"
	GEO_IP="https://raw.githubusercontent.com/Loyalsoldier/geoip/release/geoip-only-cn-private.dat"
    cd ./luci-app-openclash/root/etc/openclash/
	curl -sL -o Country.mmdb $GEO_MMDB && echo "Country.mmdb done!"
	curl -sL -o GeoSite.dat $GEO_SITE && echo "GeoSite.dat done!"
	curl -sL -o GeoIP.dat $GEO_IP && echo "GeoIP.dat done!"
	cd $PKG_PATCH && echo "openclash GeoDate has been updated!"

	#修改"ls -l /sys/class/net/ |awk '{print \$9}' 2>&1"方法导致的内存OOM
    cd ./luci-app-openclash/root/usr/share/openclash/
	awk '{
 	 if ($0 ~ /ls[[:space:]]+-l[[:space:]]+\/sys\/class\/net\/.*\|[[:space:]]*awk/) {
   	 print "for f in /sys/class/net/*;do echo ${f##*/};done";
  	  next
 	 }
	  print
	}' ./yml_change.sh > ./yml_change.sh.bak && mv ./yml_change.sh.bak ./yml_change.sh
    cd $PKG_PATCH && echo "ls -l /sys/class/net |awk '{print \$9}' 2>&1 has been replace"
fi

#添加FakeSIP和FakeHTTP
if [ -d *"openclash"* ]; then
	FakeHTTP="https://github.com/MikeWang000000/FakeHTTP/releases/latest/download/fakehttp-linux-$CORE_TYPE.tar.gz"
	FakeSIP="https://github.com/MikeWang000000/FakeSIP/releases/latest/download/fakesip-linux-$CORE_TYPE.tar.gz"
    cd ./luci-app-openclash/root/etc/openclash/
    curl -sL -o FakeHTTP.tar.gz $FakeHTTP && tar -zxf FakeHTTP.tar.gz && echo "FakeHTTP done!"
	curl -sL -o FakeSIP.tar.gz $FakeSIP && tar -zxf FakeSIP.tar.gz && echo "FakeSIP done!"
    chmod +x ./* && rm -rf ./*.gz
	cd $PKG_PATCH && echo "FakeSIP FakeHTTP has been updated!"
fi

#修改argon主题字体和颜色
if [ -d *"argon"* ]; then
	cd ./luci-theme-argon/
	sed -i "/font-weight:/ { /important/! { /\/\*/! s/:.*/: var(--font-weight);/ } }" $(find ./luci-theme-argon -type f -iname "*.css")
	cd $PKG_PATH && echo "theme-argon has been fixed!"
fi
