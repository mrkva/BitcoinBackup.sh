# BitcoinBackup.sh, simple encrypt & backup script for your Bitcoin wallet
# Copyright (C) 2011  Jonas Gruska
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

###############################

# Define your desired backup folder
BACKUP_FOLDER=~/Documents/BitcoinBackups

# Define your Bitcoin wallet location. As example you see default Mac OS X location.
WALLET_FILE=~/Library/Application\ Support/Bitcoin/wallet.dat

###############################
APPCHK=$(ps -ea | grep bitcoin | grep -v grep | wc -l)

trap 'echo Aborted.; exit 1' 2
echo "Bitcoin backup started."

# Check if Bitcoin is running
if [$APPCHK -eq 1 ]
then
    echo "Bitcoin appears to be running, please quit it before backup"; exit 1
else
    echo " "
fi
 

if [ ! -d "$BACKUP_FOLDER" ]
then
	mkdir "$BACKUP_FOLDER"
fi

cp "$WALLET_FILE" "$BACKUP_FOLDER"
cd "$BACKUP_FOLDER"

# Encryption
openssl des3 -salt -in wallet.dat -out wallet.dat.des-ede3-cbc

# Ged md5 sum and write into info.txt
md5 wallet.dat >> info.txt

echo "\nDecryption command:"
echo "\nopenssl des3 -d -salt -in wallet.dat.des-ede3-cbc -out wallet.dat" >> info.txt
rm wallet.dat
filename="Bitcoin_wallet_"`eval date +%Y%m%d`".tgz"

# Pack it all in .tgz
tar -zcvf $filename wallet.dat.des-ede3-cbc info.txt
rm wallet.dat.des-ede3-cbc
rm info.txt

echo "Success!"
exit
