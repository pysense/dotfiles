#!/bin/bash
# 更新配置文件软链接

dotfiles=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
dotfiles_home=$dotfiles/home
pushd $dotfiles > /dev/null

link() {
    from="$1"
    to="$2"
    if [[ -L $to ]]; then
        echo "- remove symlink $to"
        rm -f "$to"
    elif [[ -f $to ]]; then
        echo "- backup $to to $to.backup"
        mv $to $to.backup
    fi
    echo "* Linking '$from' to '$to'"
    ln -s "$from" "$to"
}

for link_from in $(find $dotfiles_home -maxdepth 1 | sed '1d'); do
    link_to="$HOME/.${link_from##*/}"
    link "$link_from" "$link_to"
done

popd > /dev/null
