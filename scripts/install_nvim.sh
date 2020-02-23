set -ex

INSTALL_LOG_DIR="$HOME/.install-log"
mkdir -p $INSTALL_LOG_DIR
NVIM_DONE="$INSTALL_LOG_DIR/nvim.done"
if [ ! -e "$NVIM_DONE" ]; then
    BASE_DIR=`pwd`
    add-apt-repository ppa:neovim-ppa/stable
    apt-get update
    apt-get install -y neovim
    update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    update-alternatives --config vi
    update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    update-alternatives --config vim
    update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    update-alternatives --config editor

    pip3 install msgpack --upgrade --user
    pip3 install pynvim --upgrade --user
    mkdir -p ~/.config/nvim/autoload
    ln -s $BASE_DIR/../config/nvim/init.vim ~/.config/nvim/init.vim
    wget -P ~/.config/nvim/autoload https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim -c PlugInstall
    touch $NVIM_DONE
fi

