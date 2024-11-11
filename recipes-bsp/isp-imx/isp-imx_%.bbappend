FILESEXTRAPATHS:prepend := "${THISDIR}/imx219:"


SRC_URI += "file://0001-isp-imx-add-imx219.patch" 
SRC_URI += "file://0002-isp-imx-make-imx219-default.patch"
SRC_URI += "file://0003-feat-add-dual-imx219-configuration.patch"
SRC_URI += "file://0004-fix-make-run.sh-runnable-from-everywhere.patch"

FILES_SOLIBS_VERSIONED += " \
    ${libdir}/libimx219.so \
"
