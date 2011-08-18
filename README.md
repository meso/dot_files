シェル
=======

> $ git clone git@github.com:meso/dot_files.git .dot_files

> $ ln -s ~/.dot_files/.bashrc .bashrc

端末ごと
--------

> $ ln -s ~/.dot_files/.profile .profile // for Mac
> 
> $ vim .dot_files/.bash_extra //各端末向けに修正
> 
> $ ln -s ~/.dot_files/.bash_extra .bash_extra

Vim
====

> $ ln -s ~/.dot_files/.vimrc .vimrc

> $ ln -s ~/.dot_files/.vim .vim

vundle対応
----------

> $ cd .dot_files
>
> $ git submodule init
>
> $ git submodule update
> 
> $ vim hoge //:BundleInstall

