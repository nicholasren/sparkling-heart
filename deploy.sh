#!/usr/bin/env bash

# scp -r build pi@192.168.1.100:/data/sparkling-heart
ansible-playbook --inventory-file=deploy/inventory/pi.ini deploy/app.yml --user pi

