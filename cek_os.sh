#!/bin/bash
#-------------------------------------------
# [cek_os.sh]
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

# Mengecek sistem operasi
echo -e "${b}[*] ${p}Mengecek sistem operasi...${r}"
sleep 3
sistem_operasi=$(uname -s)
if [[ "${sistem_operasi}" != "Linux" ]]; then
        echo -e "${m}[-] ${p}Sistem operasi Anda tidak mendukung untuk menjalankan program Jono.${r}"
        exit 1
fi

# Mengecek ID Linux
file_id_linux="/etc/os-release"
if [[ ! -f "${file_id_linux}" ]]; then
        echo -e "${m}[-] ${p}File '${file_id_linux}' tidak ditemukan. Sistem operasi Anda tidak mendukung untuk menjalankan program Jono.${r}"
        exit 1
fi
. "${file_id_linux}"
id_linux=$ID
if [[ "${id_linux}" != "debian" && "${id_linux}" != "ubuntu" && "${id_linux}" != "kali" ]]; then
        echo -e "${m}[-] ${p}Sistem operasi Anda tidak mendukung untuk menjalankan program Jono.${r}"
        exit 1
fi

echo -e "${h}[+] ${p}Sistem operasi Anda: ${sistem_operasi} (${id_linux})."
