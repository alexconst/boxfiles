#!/bin/bash

# enable contrib and non-free repos
sed -i 's/^\(deb.*main\)$/\1 contrib non-free/g' /etc/apt/sources.list
apt-get update

