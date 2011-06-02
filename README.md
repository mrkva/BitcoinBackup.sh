#BitcoinBackup.sh
Inspired by [this](http://plasticliving.blogspot.com/2011/05/my-preferred-way-to-backup-bitcoin.html) blog.
##Simple Bitcoin wallet backup script
This script allows you to simply encrypt and backup your Bitcoin wallet. It creates a directory for your backups and packs the encrypted `wallet.dat` with textfile containing md5 sum and command for decryption.

##Setup
1. Open the script and define your desired Backup directory and location of your `wallet.dat` in your system (depending on your platform).
2. Run the script: `sh BitcoinBackup.sh`
3. Enjoy!
