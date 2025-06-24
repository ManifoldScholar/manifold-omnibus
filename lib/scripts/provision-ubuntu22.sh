#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y build-essential libc6-dev
