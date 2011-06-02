#!/bin/bash

# Simple Bitcoin backup

# Define your desired backup folder

BACKUP_FOLDER=~/Documents/BitcoinBackups

# Define your Bitcoin wallet location. As example you see default Mac OS X location.

WALLET_FILE=~/Library/Application\ Support/Bitcoin/wallet.dat

if [ ! -d "$BACKUP_FOLDER" ]
then
	mkdir "$BACKUP_FOLDER"
fi

cp "$WALLET_FILE" "$BACKUP_FOLDER"
cd "$BACKUP_FOLDER"
openssl des3 -salt -in wallet.dat -out wallet.dat.des-ede3-cbc
md5 wallet.dat >> info.txt
echo "\nDecryption command:"
echo "\nopenssl des3 -d -salt -in wallet.dat.des-ede3-cbc -out wallet.dat" >> info.txt
rm wallet.dat
filename="Bitcoin_wallet_"`eval date +%Y%m%d`".tgz"
tar -zcvf $filename wallet.dat.des-ede3-cbc info.txt
rm wallet.dat.des-ede3-cbc
rm info.txt
echo "Success!"
exit
