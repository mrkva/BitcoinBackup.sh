# BitcoinDecrypt.sh, simple decrypt script for your backup made with BitcoinBackup.sh
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

# Simple Bitcoin decrypt

########## SETUP ##############
# There is no setup. Just run the script inside the folder with your backups.
# IMPORTANT: Be sure to pick the latest copy of your wallet!
# Always keep the copy of your wallet.dat when you're replacing it with other one!

# These are possible locations where to put wallet.dat after it is decrypted by script
#
# Mac OS X location
# ~/Library/Application\ Support/Bitcoin/wallet.dat

# Under Linux / UNIX
# WALLET_FILE=~/.bitcoin/wallet.dat

# Under Windows
# WALLET_FILE=%APPDATA%\Bitcoin\wallet.dat

###############################

echo "Bitcoin decrypt started."

ABSOLUTEPATH=$(dirname $1)

OUTDIR="$ABSOLUTEPATH""/wallet_"$(eval date +%Y%m%d)

trap 'echo Aborted.; rm -rf $OUTDIR; exit 1' INT

mkdir $OUTDIR
cd $OUTDIR
tar xvf $1 

# Decryption
if ! openssl aes-256-cbc -d -a -salt -in wallet.dat.aes-256-cbc -out wallet.dat
	then echo "Decryption was unsuccesful. Probably wrong password"; exit 1;
fi
rm wallet.dat.aes-256-cbc

BACKUPMD5=$(head -n 1 info.txt)
ORIGMD5=$(md5 wallet.dat)

echo "md5 sum of original backup wallet.dat: "$BACKUPMD5
echo "md5 sum of the decrypted wallet.dat:   "$ORIGMD5
echo
echo "Success!"
echo "Your decrypted wallet.dat was saved to: "
echo "		"$OUTDIR
echo "IMPORTANT: Make sure that Bitcoin or bitcoind is not running while operating with wallet and backup your current wallet.dat before you replace it with decrypted one!"
echo
