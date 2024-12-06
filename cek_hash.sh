#!/bin/bash
# [cek_hash.sh]
# File ini merupakan bagian dari proyek Jono
# Dibuat oleh: fixploit03
#-------------------------------------------
# Mau ngapain sih Broh ^_^

# warna
m="\e[1;31m"
p="\e[1;37m"
r="\e[0m"

# File dan Hash
deb="src/jono_deb_ubuntu.sh"
kali="src/jono_kali.sh"
hash_deb="791e1b02f2411156e11d5c637433ffd1"
hash_kali="9688bd0f4288bda758c3610f7839590c"

if [[ $(md5sum "${deb}" | awk '{print $1}') != "${hash_deb}" || $(md5sum "${kali}" | awk '{print $1}') != "${hash_kali}" ]]; then
	echo -e "${p}[${m}-${p}] Jangan di recode Broh! kalo mau berkontribusi aja :).${r}"
	exit 1
fi
