#!/bin/bash
#-------------------------------------------
# [instal.sh]
# File ini merupakan bagian dari proyek Jono
# Dibuat oleh: fixploit03 
#-------------------------------------------
# Mau ngapain sih Broh ^_^

# Variabel warna
m="\e[1;31m" # Merah
h="\e[1;32m" # Hijau 
k="\e[1;33m" # Kuning 
b="\e[1;34m" # Biru 
p="\e[1;37m" # Putih 
r="\e[0m"    # Reset 

# Cek root
if [[ "$EUID" -ne 0 ]]; then
        echo -e "${m}[-] ${p}Script ini harus dijalankan sebagai root.${r}"
        exit 1
fi

john="/usr/share/john"


# Membersihkan layar Terminal 
clear

# Menampilkan banner
echo -e ""
echo -e "${p}╦╔╗╔╔═╗╔╦╗╔═╗╦    ${k}╦╔═╗╔╗╔╔═╗${r}"
echo -e "${p}║║║║╚═╗ ║ ╠═╣║    ${k}║║ ║║║║║ ║${r}"
echo -e "${p}╩╝╚╝╚═╝ ╩ ╩ ╩╩═╝ ${k}╚╝╚═╝╝╚╝╚═╝${r}"
echo ""
echo -e "${b}[*] ${p}Selamat datang di menu instalasi Jono${r}"
echo -e "${b}[*] ${p}Pembuat: fixploit03${r}"
echo -e "${b}[*] ${p}Github: https://github.com/fixploit03/Jono/${r}"
echo ""

# Nanya 
while true; do
        read -p $'\e[1;33m[?] \e[1;37mApakah Anda ingin menginstal Jono [Y/n]: \e[1;33m' nanya
        if [[ -z "${nanya}" ]]; then
                echo -e "${m}[-] ${p}Masukkan tidak boleh kosong.${r}"
                continue
        fi
        if [[ "${nanya}" != "y" && "${nanya}" != "Y" && "${nanya}" != "n" && "${nanya}" != "N" ]]; then
                echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'Y/n'.${r}"
                continue
        fi
        break
done

if [[ "${nanya}" == "n" || "${nanya}" == "N" ]]; then
        echo -e "${h}[+] ${p}Semoga harimu menyenangkan ^_^${r}"
        exit 0
fi

if [[ ! -d "${john}" ]]; then
    bash instal_john.sh
fi

echo -e "${b}[*] ${p}Mengingat Jono...${r}"
chmod +x jono.sh
cp jono.sh /usr/local/bin/jono
echo -e "${h}[+] ${p}Berhasil menginstal Jono. Ketikkan perintah 'Jono' untuk menjalankannya.${r}"
exit 0
