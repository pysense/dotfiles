#!/bin/bash
# 移除配置文件软链接，并恢复原有备份

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

unlink() {
    from="$1"
    to="$2"
    if [[ -L $to ]]; then
        abs_path=$(readlink -f $to)
        if [[ $abs_path == $from ]]; then
            echo "- remove symlink $to"
            rm -f "$to"
            if [[ -f $to.backup ]]; then
                echo "+ restore $to.backup to $to"
                mv $to.backup $to
            fi
        fi
    else
        if [[ -f $to ]]; then
            echo "* $to not a symlink"
        fi
    fi
}

for link_from in $(find $dotfiles_home -maxdepth 1 | sed '1d'); do
    link_to="$HOME/.${link_from##*/}"
    unlink "$link_from" "$link_to"
done

popd > /dev/null
