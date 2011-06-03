#BitcoinBackup.sh
Inspired by [this](http://plasticliving.blogspot.com/2011/05/my-preferred-way-to-backup-bitcoin.html) blog.  
Spare some change?  
`1A71MsTCyDgH1RRaXuneWom98DGQHBskhh`  
Thanks!
##Simple Bitcoin wallet backup script
This script allows you to simply __encrypt__ (with AES-256) and __backup__ your Bitcoin wallet. It creates a directory for your backups and packs the encrypted `wallet.dat` with textfile containing md5 sum and in case you forget (maybe while on other computer), command for decryption. In the end, you can setup SCP command (provided) for your server - backup yor wallet remotely, or just send it to your online e-mail account.

##Setup & usage
1. Open the script and define your desired backup folder via `$BACKUP_FOLDER` variable and location of your `wallet.dat` (using `$WALLET_FILE`) in your system (depending on your platform). If you want to use remote backup, setup also your username `$USER`, server `$SERVER` and remote directory `$REMOTE_DIR`.
2. Run the script: `sh BitcoinBackup.sh`. Script checks if `bitcoin` or `bitcoind` aren't running.
3. Enter desired encryption password.
4. (optional) In case you set up SCP backup, script will ask you for password.
5. Enjoy!

