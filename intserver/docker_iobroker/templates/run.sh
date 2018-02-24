#!/bin/sh

cd /opt/iobroker/
npm install iobroker --unsafe-perm
node node_modules/iobroker.js-controller/controller.js
