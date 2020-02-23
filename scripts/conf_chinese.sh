#!/bin/bash
set -ex

INSTALL_LOG_DIR="$HOME/.install-log"
mkdir -p $INSTALL_LOG_DIR
PROFILE_DONE="$INSTALL_LOG_DIR/profile.done"
if [ ! -e "$PROFILE_DONE" ]; then
    export LANG="C.UTF-8"
    source /etc/profile
    touch $PROFILE_DONE
fi
