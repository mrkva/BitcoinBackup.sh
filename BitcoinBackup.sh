# BitcoinBackup.sh, simple encrypt & backup script for your Bitcoin wallet
# Copyright (C) 2011  Jonas Gruska, http://mrkva.ovecka.be
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#!/bin/bash

# Simple Bitcoin backup

########## SETUP ##############

# Define your desired backup folder
BACKUP_FOLDER=~/Documents/BitcoinBackups

# Define your Bitcoin wallet location. Just uncomment the one you
# are going to use and comment the others with '#' 
# Mac OS X location
WALLET_FILE=~/Library/Application\ Support/Bitcoin/wallet.dat

# Under Linux / UNIX
# WALLET_FILE=~/.bitcoin/wallet.dat

# Under Windows
# WALLET_FILE=%APPDATA%\Bitcoin\wallet.dat

# Setup for remote backup (SCP)
# USER="John"
# SERVER="Server.org"
# REMOTE_DIR="~/wallets"

###############################
APPCHK=$(ps -ea | grep bitcoin | grep -v grep | wc -l)

# Trap for ^C
trap 'echo Aborted.; rm $BACKUP_FOLDER/wallet.dat; exit 1' 2

echo "Bitcoin backup started."

# Check if Bitcoin is running
if [$APPCHK -eq 1 ]
then
    echo "Bitcoin appears to be running, please quit it before you start this process."; exit 1
fi
 

if [ ! -d "$BACKUP_FOLDER" ]
then
    mkdir "$BACKUP_FOLDER"
fi

cp "$WALLET_FILE" "$BACKUP_FOLDER"
cd "$BACKUP_FOLDER"

# Encryption
openssl aes-256-cbc -a -salt -in wallet.dat -out wallet.dat.aes-256-cbc

# Ged md5 sum and write into info.txt
rm info.txt
md5 wallet.dat >> info.txt

# Put in the instructions
echo "\nDecryption command:" >> info.txt
echo "\nopenssl aes-256-cbc -d -a -salt -in wallet.dat.aes-256-cbc -out wallet.dat" >> info.txt
rm wallet.dat

FILENAME="Bitcoin_wallet_"`eval date +%Y%m%d`".tgz"

# Pack it all in .tgz
tar -zcvf $FILENAME wallet.dat.aes-256-cbc info.txt
rm wallet.dat.aes-256-cbc
rm info.txt

# If you want to use your server, you can use SCP. Just uncomment following lines
# and fill out your info at the SETUP part of this script
#
# echo "Attempting to connect to "$SERVER
# if scp $FILENAME $USER@$SERVER:"$REMOTE_DIR"
# then 
#    echo "Success!"
# else
#    echo "Remote connection failed"; exit 1;
# fi
