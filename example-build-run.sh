#!/bin/bash
set -x
set -euvo pipefail
IFS=$'\n\t'

# Requires Node.js version 4.x
# Do not run as root

DEPLOY_DIR=/var/www/rocket.chat

### BUILD
cd /ic
sudo meteor npm install
sudo meteor npm run postinstall

# on the very first build, meteor build command should fail due to a bug on emojione package (related to phantomjs installation)
# the command below forces the error to happen before build command (not needed on subsequent builds)
set +e
sudo meteor add rocketchat:lib
set -e

sudo meteor build --server-only --directory $DEPLOY_DIR

### RUN
# cd $DEPLOY_DIR/bundle/programs/server
# sudo npm install

# cd $DEPLOY_DIR/bundle
# NODE_ENV=production \
# PORT=3000 \
# ROOT_URL=http://localhost:3000 \
# MONGO_URL=mongodb://localhost:27017/rocketchat \
# MONGO_OPLOG_URL=mongodb://localhost:27017/local \
# node main.js
