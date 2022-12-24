#!/bin/bash

# Use steamcmd to login anonymously and download the game to /data.
#
# Some games require a steam account to login to verify purchase. In that case,
# add your steam login info into .env, then use the variables here.
# More info: https://developer.valvesoftware.com/wiki/SteamCMD#With_a_Steam_Account
steamcmd \
  +login anonymous \
  +force_install_dir /data \
  +app_update [steam-app-id] \
  +quit

# Change to the game's install directory
cd /data

./[game-executable] \
  -param1 "$PARAM1" \
  -param2 "$PARAM2"
