## Intalasi Jono Termux

```
$ termux-setup-storage
$ pkg update
$ pkg upgrade
$ pkg install proot-distro
$ proot-distro install debian
$ proot-distro login debian 
$ apt-get update
$ apt-get install python3
$ apt-get install git
$ git clone --depth 1 https://github.com/fixploit03/Jono.git
$ cd Jono
$ ln -s /usr/bin/python3 /usr/bin/python
$ chmod +x instal_john.sh jono.sh
$ ./instal_john.sh
```
