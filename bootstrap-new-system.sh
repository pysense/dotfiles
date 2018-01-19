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
    # 返回变量
    #     $OS_BIT 系统位数
    #     $OS 系统名称
    #     $OS_VERSION 系统版本号

    OS_BIT=$(getconf LONG_BIT)

    # 获取 CentOS, RedHat 系统版本
    if [[ -r /etc/redhat-release ]]; then
        eval $(awk '/release/ {for(i=1;i<=NF;i++) if($i ~ /[0-9.]+/) {print "OS="$1"\nOS_VERSION="$i}}' /etc/redhat-release)
        [[ "$OS" == "Red" ]] && OS="RedHat"
        [[ -n "$OS" && -n "$OS_VERSION" ]] && return
    fi

    # 获取 Ubuntu 系统版本
    if [[ -r /etc/lsb-release ]]; then
        eval $(awk '/^DISTRIB_ID/ || /^DISTRIB_RELEASE/ {print}' /etc/lsb-release)
        OS=$DISTRIB_ID; OS_VERSION=$DISTRIB_RELEASE
        [[ -n "$OS" && -n "$OS_VERSION" ]] && return
    fi
    
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
