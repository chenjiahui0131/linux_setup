set -ex

INSTALL_LOG_DIR="$HOME/.install-log"
mkdir -p $INSTALL_LOG_DIR
TMUX_DONE="$INSTALL_LOG_DIR/tmux.done"
if [ ! -e "$TMUX_DONE" ]; then
	BASE_DIR=`pwd`
	cd /tmp/
	wget -N https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a.tar.gz
	tar -zxf tmux-*.tar.gz
	cd tmux-3.0a/
	./configure
	make && make install
	cd $BASE_DIR
	rm -f ~/.tmux.conf
	ln -s $BASE_DIR/../config/tmux/.tmux.conf ~/.tmux.conf
	touch $TMUX_DONE
fi
