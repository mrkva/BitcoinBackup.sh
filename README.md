#BitcoinBackup.sh
Inspired by [this](http://plasticliving.blogspot.com/2011/05/my-preferred-way-to-backup-bitcoin.html) blog.
##Simple Bitcoin wallet backup script
This script allows you to simply encrypt and backup your Bitcoin wallet. It creates a directory for your backups and packs the encrypted `wallet.dat` with textfile containing md5 sum and in case you forget (maybe while on other computer), command for decryption. In the end, you can setup SCP command (provided) for your server, and backup yor wallet remotely.

__Encryption of wallet -> Packing it with useful info (md5 and decryption command), putting date in the name of the file -> SCP to your server (optional)__

##Setup
1. Open the script and define your desired backup folder via `$BACKUP_FOLDER` variable and location of your `wallet.dat` (using `$WALLET_FILE`) in your system (depending on your platform).
2. Run the script: `sh BitcoinBackup.sh`. Script checks if `bitcoin` or `bitcoind` aren't running.
3. Enter desired encryption password.
4. Enjoy!

