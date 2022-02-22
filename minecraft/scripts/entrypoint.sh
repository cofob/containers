#!/bin/bash

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $NF;exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Print Java version
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mjava -version\n"
java -version

# Detect built-in git
if [[ -d "/data/.git" ]]; then
	if [[ -d "/home/container/.git" ]]; then
		printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mDetected built-it git, using\n"
		printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mrm -rf ~/.git\n"
		rm -rf ~/.git
	fi
	printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mmv /data/.git ~/.git\n"
	cp -r /data/.git ~/.git
fi

# Git reset
if [[ -d "/home/container/.git" ]]; then
	if [[ -d "/data/.git" ]]; then
		if [[ -d "plugins" ]]; then
			printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mrm -rf plugins/*.jar\n"
			rm -rf plugins/*.jar
		fi
	fi
	printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mgit reset --hard\n"
	git reset --hard
	if [[ -d "/data/.git" ]]; then
		printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mrm -rf ~/.git\n"
		rm -rf ~/.git
	fi
fi

# Python scripts
# Load plugins
if [[ ! -d "/data/.git" ]]; then
	if [[ -f "/home/container/config.json" ]]; then
		printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mpython3 load_plugins.py\n"
		python3 /load_plugins.py
	fi
fi

# Apply secrets
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mpython3 apply_secrets.py\n"
python3 /apply_secrets.py

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}

# Git reset
if [[ -d "/home/container/.git" ]]; then
	printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mgit reset --hard\n"
	git reset --hard
fi
