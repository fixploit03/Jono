#!/bin/bash
#-------------------------------------------
# [jono.sh]
# File ini merupakan bagian dari proyek Jono
# Dibuat oleh: fixploit03
#-------------------------------------------
# Mau ngapain sih Broh ^_^

# Variabel warna
m="\e[1;31m" # Merah
h="\e[1;32m" # Hijau
b="\e[1;34m" # Biru
p="\e[1;37m" # Putih
r="\e[0m"    # Reset

# Cek root
if [[ "$EUID" -ne 0 ]]; then
        echo -e "${m}[-] ${p}Script ini harus dijalankan sebagai root.${r}"
        exit 1
fi

# Lokasi folder untuk menyimpan file hash
lokasi_file_hash="file_hash"

if [[ ! -d "${lokasi_file_hash}" ]]; then
        mkdir -p "${lokasi_file_hash}"
fi

# Membersihkan layar Terminal
clear
