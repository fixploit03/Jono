## Intalasi Jono Termux

> Jika belum memiliki Termux, Anda dapat mengunduhnya [disini](https://github.com/termux/termux-app/releases/download/v0.118.1/termux-app_v0.118.1+github-debug_universal.apk).

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
