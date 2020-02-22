set -ex

INSTALL_LOG_DIR="$HOME/.install-log"
mkdir -p $INSTALL_LOG_DIR
ZSH_DONE="$INSTALL_LOG_DIR/zsh.done"
if [ ! -e "$TMUX_DONE" ]; then
	BASE_DIR=`pwd`
	apt-get install -y zsh
	sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
	sed -i "s/robbyrussell/agnoster/g" ~/.zshrc
	chsh -s /usr/bin/zsh $USER
	touch ZSH_DONE
fi

