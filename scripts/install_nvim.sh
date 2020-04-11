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

	apt-get install -y exuberant-ctags
	bash -c "$(wget install-node.now.sh/lts -O -)"
    pip3 install msgpack --upgrade --user
    pip3 install jedi flake8 pynvim --upgrade --user
	apt-get install -y clang-format
	apt-get install -y python-autopep8
	apt-get install -y pylint
    mkdir -p ~/.config/nvim/autoload
    ln -s $BASE_DIR/../config/nvim/init.vim ~/.config/nvim/init.vim
    ln -s $BASE_DIR/../config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
    wget -P ~/.config/nvim/autoload https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim -c PlugInstall
	echo "Please using CocInstall to install coc-json coc-python coc-highlight coc-lists"
    touch $NVIM_DONE
fi

