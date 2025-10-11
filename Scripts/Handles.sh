#!/bin/bash

PKG_PATCH="$GITHUB_WORKSPACE/wrt/package/"
APP_PATCH="$GITHUB_WORKSPACE/wrt/feeds/luci/applications/"
#THEMES_PATCH="$GITHUB_WORKSPACE/wrt/feeds/luci/themes/"

#预置OpenClash内核和数据
cd $APP_PATCH
if [ -d *"luci-app-openclash"* ]; then

	if echo "$WRT_TARGET" | grep -Eiq "64|86"; then
	    CORE_TYPE="amd64"
	elif echo "$WRT_TARGET" | grep -Eiq "IPQ807X"; then
	    CORE_TYPE="arm64"
	elif echo "$WRT_TARGET" | grep -Eiq "MT7621"; then
	    CORE_TYPE="mipsle-softfloat"
	else
	    CORE_TYPE="$WRT_TARGET"  # 默认情况下返回WRT_TARGET的值
	fi
 
	#CORE_MATE="https://github.com/vernesong/OpenClash/raw/core/master/meta/clash-linux-$CORE_TYPE.tar.gz"
    #换用samrt内核
	CORE_MATE="https://github.com/vernesong/OpenClash/raw/core/master/smart/clash-linux-$CORE_TYPE.tar.gz"
	cd ./luci-app-openclash/root/etc/openclash/
	mkdir ./core/ && cd ./core/
	curl -sL -o meta.tar.gz $CORE_MATE && tar -zxf meta.tar.gz && mv -f clash clash_meta && echo "meta done!"
	chmod +x ./* && rm -rf ./*.gz
    cd $APP_PATCH && echo "openclash core has been updated!"
	
	GEO_MMDB="https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country-only-cn-private.mmdb"
	GEO_SITE="https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat"
	GEO_IP="https://raw.githubusercontent.com/Loyalsoldier/geoip/release/geoip-only-cn-private.dat"
    cd ./luci-app-openclash/root/etc/openclash/
	curl -sL -o Country.mmdb $GEO_MMDB && echo "Country.mmdb done!"
	curl -sL -o GeoSite.dat $GEO_SITE && echo "GeoSite.dat done!"
	curl -sL -o GeoIP.dat $GEO_IP && echo "GeoIP.dat done!"
	cd $APP_PATCH && echo "openclash GeoDate has been updated!"

    #预置训练模型
	LightGBMModel="https://github.com/vernesong/mihomo/releases/download/LightGBM-Model/Model.bin"
    cd ./luci-app-openclash/root/etc/openclash/
    curl -sL -o Model.bin $LightGBMModel && echo "LightGBMModel done!"
	cd $APP_PATCH
 
	#修改"ls -l /sys/class/net/ |awk '{print \$9}' 2>&1"方法导致的内存OOM
    cd ./luci-app-openclash/root/usr/share/openclash/
	awk '{
 	 if ($0 ~ /ls[[:space:]]+-l[[:space:]]+\/sys\/class\/net\/.*\|[[:space:]]*awk/) {
   	 print "for f in /sys/class/net/*;do echo ${f##*/};done";
  	  next
 	 }
	  print
	}' ./yml_change.sh > ./yml_change.sh.bak && mv ./yml_change.sh.bak ./yml_change.sh
    cd $APP_PATCH && echo "ls -l /sys/class/net |awk '{print \$9}' 2>&1 has been replace"
fi

#添加FakeSIP和FakeHTTP
cd $APP_PATCH
if [ -d *"luci-app-openclash"* ]; then
	FakeHTTP="https://github.com/MikeWang000000/FakeHTTP/releases/latest/download/fakehttp-linux-$CORE_TYPE.tar.gz"
	FakeSIP="https://github.com/MikeWang000000/FakeSIP/releases/latest/download/fakesip-linux-$CORE_TYPE.tar.gz"
    cd ./luci-app-openclash/root/etc/openclash/
    curl -sL -o FakeHTTP.tar.gz $FakeHTTP && tar -zxf FakeHTTP.tar.gz
	curl -sL -o FakeSIP.tar.gz $FakeSIP && tar -zxf FakeSIP.tar.gz
    mv ./fakehttp-linux-$CORE_TYPE/fakehttp ./ && echo "FakeHTTP done!" && rm -rf ./fakehttp-linux-$CORE_TYPE
	mv ./fakesip-linux-$CORE_TYPE/fakesip ./ && echo "FakeSIP done!" && rm -rf ./fakesip-linux-$CORE_TYPE
    chmod +x ./fakehttp ./fakesip && rm -rf ./*.gz
	cd $APP_PATCH && echo "FakeSIP FakeHTTP has been updated!"
fi

cd $PKG_PATCH
