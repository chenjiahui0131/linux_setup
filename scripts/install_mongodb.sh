set -ex

INSTALL_LOG_DIR="$HOME/.install-log"
mkdir -p $INSTALL_LOG_DIR
MONGODB_DONE="$INSTALL_LOG_DIR/mongodb.done"
if [ ! -e "$MONGODB_DONE" ]; then
	apt-get install -y libcurl4 tzdata
	BASE_DIR=`pwd`
	cd /tmp/
	wget -N https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/4.2/multiverse/binary-amd64/mongodb-org-server_4.2.3_amd64.deb
	dpkg -i mongodb-org-server_4.2.3_amd64.deb
    wget -N https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/4.2/multiverse/binary-amd64/mongodb-org-shell_4.2.3_amd64.deb
    dpkg -i mongodb-org-shell_4.2.3_amd64.deb
	cd $BASE_DIR
	mkdir -p /data/db
	touch $MONGODB_DONE
fi
