#!/bin/bash
# Author: pysense <pysense@gmail.com>

[[ $debug == "" ]] && debug=0

set -o errexit
set -o nounset


debug() {
    [[ $debug -ne 1 ]] && return
    case "$1" in
        "var")
            eval echo "$2=\$$2"
            ;;
    esac
}

error() {
    echo "错误：$*"
    exit 1
}

check_os() {
    OS=
    OS_BIT=
    CentOS_RHEL_version=
    OS_BIT=$(getconf LONG_BIT)
    if [[ -e /etc/redhat-release ]]; then
        eval $(awk '{print "OS="$1"\nCentOS_RHEL_version="$4}' /etc/redhat-release)
    else
        check_os_unsupport
    fi
}

check_os_unsupport() {
    #TODO 收集相关文件信息
    error "脚本暂时不支持该系统。"
}

install() {
    case "$OS" in
        "CentOS")
            centos_init
            ;;
    esac
}

centos_init() {
    # TODO
    echo -e "$OS $CentOS_RHEL_version init script\n"
    # sudo
    sed -i '/%wheel.*NOPASSWD/s/^#\s//' /etc/sudoers
    # /etc/ssh/sshd_config
    sed -i 's/^#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
}

[ $(id -u) != "0" ] && error "脚本需用 root 帐号运行，或者使用 sudo 执行脚本。"

check_os
debug var OS
debug var OS_BIT
debug var CentOS_RHEL_version

install
