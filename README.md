# dotfiles

存放一些配置文件与初始化脚本。

## 安装

### dotfiles

```
git clone https://github.com/pysense/dotfiles ~/.dotfiles
cd ~/.dotfiles

# 软链接配置文件
bash symlink-dotfiles.sh

# 重新加载配置文件
. ~/.bashrc
```

## 卸载

```
cd ~/.dotfiles
bash unsymlink-dotfiles.sh
```

执行卸载脚本后删除 `~/.dotfiles`

## 参考

- [paulmillr/dotfiles: Colourful & robust OS X configuration files and utilities.](https://github.com/paulmillr/dotfiles)
