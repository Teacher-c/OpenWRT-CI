#!/bin/bash

#curl supports h3/quic.
# nghttp3
rm -rf feeds/packages/libs/nghttp3
git clone https://github.com/sbwml/package_libs_nghttp3 package/libs/nghttp3
# ngtcp2
rm -rf feeds/packages/libs/ngtcp2
git clone https://github.com/sbwml/package_libs_ngtcp2 package/libs/ngtcp2
# curl - http3/quic
rm -rf feeds/packages/net/curl
git clone https://github.com/sbwml/feeds_packages_net_curl feeds/packages/net/curl

pushd package/libs/openssl/patches
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0001-QUIC-Add-support-for-BoringSSL-QUIC-APIs.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0002-QUIC-New-method-to-get-QUIC-secret-length.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0003-QUIC-Make-temp-secret-names-less-confusing.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0004-QUIC-Move-QUIC-transport-params-to-encrypted-extensi.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0005-QUIC-Use-proper-secrets-for-handshake.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0006-QUIC-Handle-partial-handshake-messages.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0007-QUIC-Fix-quic_transport-constructors-parsers.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0008-QUIC-Reset-init-state-in-SSL_process_quic_post_hands.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0009-QUIC-Don-t-process-an-incomplete-message.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0010-QUIC-Quick-fix-s2c-to-c2s-for-early-secret.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0011-QUIC-Add-client-early-traffic-secret-storage.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0012-QUIC-Add-OPENSSL_NO_QUIC-wrapper.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0013-QUIC-Correctly-disable-middlebox-compat.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0014-QUIC-Move-QUIC-code-out-of-tls13_change_cipher_state.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0015-QUIC-Tweeks-to-quic_change_cipher_state.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0016-QUIC-Add-support-for-more-secrets.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0017-QUIC-Fix-resumption-secret.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0018-QUIC-Handle-EndOfEarlyData-and-MaxEarlyData.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0019-QUIC-Fall-through-for-0RTT.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0020-QUIC-Some-cleanup-for-the-main-QUIC-changes.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0021-QUIC-Prevent-KeyUpdate-for-QUIC.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0022-QUIC-Test-KeyUpdate-rejection.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0023-QUIC-Buffer-all-provided-quic-data.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0024-QUIC-Enforce-consistent-encryption-level-for-handsha.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0025-QUIC-add-v1-quic_transport_parameters.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0026-QUIC-return-success-when-no-post-handshake-data.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0027-QUIC-__owur-makes-no-sense-for-void-return-values.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0028-QUIC-remove-SSL_R_BAD_DATA_LENGTH-unused.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0029-QUIC-SSLerr-ERR_raise-ERR_LIB_SSL.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0030-QUIC-Add-compile-run-time-checking-for-QUIC.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0031-QUIC-Add-early-data-support.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0032-QUIC-Make-SSL_provide_quic_data-accept-0-length-data.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0033-QUIC-Process-multiple-post-handshake-messages-in-a-s.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0034-QUIC-Fix-CI.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0035-QUIC-Break-up-header-body-processing.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0036-QUIC-Don-t-muck-with-FIPS-checksums.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0037-QUIC-Update-RFC-references.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0038-QUIC-revert-white-space-change.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0039-QUIC-use-SSL_IS_QUIC-in-more-places.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0040-QUIC-Error-when-non-empty-session_id-in-CH.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0041-QUIC-Update-SSL_clear-to-clear-quic-data.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0042-QUIC-Better-SSL_clear.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0043-QUIC-Fix-extension-test.patch
    curl -sO https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/openssl/quic/0044-QUIC-Update-metadata-version.patch
popd
  

if [[ $OWRT_URL == *"openwrt"* ]] ; then
  
  #添加luci-app-zerotier及luci.mk
  # 克隆仓库
  git clone https://github.com/immortalwrt/luci.git tmp_luci
  # 移动 luci.mk 文件到根目录（确认文件不存在或者允许覆盖）
  mv tmp_luci/luci.mk ./
  # 将 luci-app-zerotier 移动到 package 目录
  mv tmp_luci/applications/luci-app-zerotier ./package/
  # 删除临时文件夹
  rm -rf tmp_luci

  #添加CPU,温度，以及nss占用信息显示
  #rm -rf feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
  #rm -rf feeds/luci/modules/luci-mod-status/root/usr/share/rpcd/acl.d/luci-mod-status.json
  #rm -rf feeds/luci/modules/luci-base/root/usr/share/rpcd/ucode/luci
  #cp -rf $GITHUB_WORKSPACE/general/AX6/nss-status/immortal/10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/
  #cp -rf $GITHUB_WORKSPACE/general/AX6/nss-status/immortal/luci-mod-status.json feeds/luci/modules/luci-mod-status/root/usr/share/rpcd/acl.d/
  #cp -rf $GITHUB_WORKSPACE/general/AX6/nss-status/luci_file_from_immortal/luci feeds/luci/modules/luci-base/root/usr/share/rpcd/ucode/
  echo 'skip'
fi
