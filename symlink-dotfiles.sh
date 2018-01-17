#!/bin/bash
# 更新配置文件软链接

dotfiles=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
pushd $dotfiles > /dev/null

link() {
    from="$1"
    to="$2"
    echo "Linking '$from' to '$to'"
    rm -f "$to"
    ln -s "$from" "$to"
}

for location in $(find files -maxdepth 1 | sed '1d'); do
    file="${location##*/}"
    link "$dotfiles/$location" "$HOME/.$file"
done

popd > /dev/null
