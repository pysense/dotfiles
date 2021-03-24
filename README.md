# dotfiles

存放一些配置文件与初始化脚本。

## 安装

### dotfiles

```
git clone https://github.com/pysense/dotfiles ~/dotfiles
# 或者
git clone git@github.com:pysense/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 软链接配置文件
bash symlink-dotfiles.sh

# 重新加载配置文件
. ~/.bashrc
```

安装是通过将相关的文件做软链接到对应的位置，
如果当前环境存在要做软链接的文件，将首先备份原文件为 `${filename}.backup`，
如果当前环境不存在要做软链接的文件，直接将文件软链接到对应的位置。

## 卸载

```
cd ~/.dotfiles
bash unsymlink-dotfiles.sh
```

卸载时如果检查的软链接文件指向的路径不是当前目录下的对应文件，则不删除该软链接，
如果检查的软链接文件存在备份文件 `${filename}.backup`，在删除软链接文件后将恢复备份文件。

执行卸载脚本后需要手动删除 `~/.dotfiles` 目录。

## 参考

- [paulmillr/dotfiles: Colourful & robust OS X configuration files and utilities.](https://github.com/paulmillr/dotfiles)
