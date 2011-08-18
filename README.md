* シェル起動時

git clone git@github.com:meso/dot_files.git .dot_files
ln -s ~/.dot_files/.bashrc .bashrc

** for Mac

ln -s ~/.dot_files/.profile .profile
.bash_extra: 各端末向けに修正

* Vim

ln -s ~/.dot_files/.vimrc .vimrc
ln -s ~/.dot_files/.vim .vim

** vundle対応

cd .dot_files
git submodule init
git submodule update

vim hoge
:BundleInstall

