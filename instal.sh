#!/bin/bash
#-------------------------------------------
# [instal.sh]
# File ini merupakan bagian dari proyek Jono
# Dibuat oleh: fixploit03 
#-------------------------------------------
# Mau ngapain sih Broh ^_^

john="/usr/share/john"

if [[ ! -d "${jihn}" ]]; then
    bash instal_john.sh
fi

chmod +x jono.sh
cp jono.sh /usr/local/bin/jono
echo -e "${h}[+] ${p}Berhasil menginstal Jono. Ketikkan perintah 'Jono' untuk menjalankannya.${r}"
exit 0
