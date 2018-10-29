#!/bin/bash
# Run your own scripts here
# This script will be run before server started
# For examples: 
# - change default config file
# - setup project
# - run composer
# - ...

# Change default timezone
if [[ -n "$TZ" ]]; then
	ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
fi
