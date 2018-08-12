#!/bin/bash
set -x
set -euvo pipefail
IFS=$'\n\t'
cd /ic
meteor npm start