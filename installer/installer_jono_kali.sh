#!/bin/bash
#-------------------------------------------
# [installer_jono_kali.sh
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
        echo -e "${p}[${m}-${p}] Script ini harus dijalankan sebagai root.${r}"
        exit 1
fi

# Membersihkan layar Terminal 
clear

# Menampilkan banner
echo -e ""
echo -e "${p}╦╔╗╔╔═╗╔╦╗╔═╗╦    ${m}╦╔═╗╦ ╦╔╗╔ ╔╦╗╦ ╦╔═╗ ╦═╗╦╔═╗╔═╗╔═╗╦═╗${r}"
echo -e "${p}║║║║╚═╗ ║ ╠═╣║    ${m}║║ ║╠═╣║║║  ║ ╠═╣║╣  ╠╦╝║╠═╝╠═╝║╣ ╠╦╝${r}"
echo -e "${p}╩╝╚╝╚═╝ ╩ ╩ ╩╩═╝ ${m}╚╝╚═╝╩ ╩╝╚╝  ╩ ╩ ╩╚═╝ ╩╚═╩╩  ╩  ╚═╝╩╚═${r}"
echo ""
echo -e "${p}[${b}*${p}] Selamat datang di menu instalasi John The Ripper${r}"
echo -e "${p}[${b}*${p}] Pembuat: fixploit03${r}"
echo -e "${p}[${b}*${p}] Github: https://github.com/fixploit03/Jono/${r}"
echo ""

# Nanya 
while true; do
        read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Apakah Anda ingin menginstal John The Ripper [Y/n]: ' nanya
        if [[ -z "${nanya}" ]]; then
                echo -e "${p}[${m}-${p}] Masukkan tidak boleh kosong.${r}"
                continue
        fi
        if [[ "${nanya}" != "y" && "${nanya}" != "Y" && "${nanya}" != "n" && "${nanya}" != "N" ]]; then
                echo -e "${p}[${m}-${p}] Masukkan tidak valid. Harap masukkan 'Y/n'.${r}"
                continue
        fi
        break
done

if [[ "${nanya}" == "n" || "${nanya}" == "N" ]]; then
        echo -e "${p}[${b}*${p}] Semoga harimu menyenangkan ^_^${r}"
        exit 0
fi

# Cek koneksi internet
echo -e "${p}[${b}*${p}] Mengecek koneksi internet...${r}"
sleep 3
if ! ping -c 4 8.8.8.8; then
        echo -e "${p}[${m}-${p}] Anda tidak memiliki koneksi internet.${r}"
        exit 1
fi

echo -e "${p}[${h}+${p}] Anda memiliki koneksi internet.${r}"

# Daftar dependensi yang diperlukan untuk menginstal John the Ripper
daftar_dependensi=(
        "systemd"
        "john-data"
        "libcompress-raw-lzma-perl"
)

# Memperbarui repositori Linux
echo -e "${p}[${b}*${p}] Memperbarui repositori Linux...${r}"
sleep 3
apt-get update -y
if [[ $? -ne 0 ]]; then
        echo -e "${p}[${m}-${p}] Gagal memperbarui repositori Linux.${r}"
        exit 1
fi

echo -e "${p}[${h}+${p}] Berhasil memperbarui repositori Linux.${r}"

# Menginstal dependensi yang diperlukan John The Ripper
echo -e "${p}[${b}*${p}] Menginstal dependensi yang diperlukan oleh John The Ripper...${r}"
sleep 3
for dependensi in "${daftar_dependensi[@]}"; do
      echo -e "${p}[${b}*${p}] Menginstal '${dependensi}'...${r}"
      sleep 3
      apt-get install "${dependensi}" -y
      if [[ $? -ne 0 ]]; then
              echo -e "${p}[${m}-${p}] Gagal menginstal '${dependensi}'.${r}"
              exit 1
      fi

      echo -e "${p}[${h}+${p}] Berhasil menginstal '${dependensi}'.${r}"
done

echo -e "${p}[${b}*${p}] Menginstal John The Ripper...${r}"
sleep 3
apt-get install john -y
if [[ $? -ne 0 ]]; then
        echo -e "${p}[${m}-${p}] Gagal menginstal John The Ripper.${r}"
        exit 1
fi

echo -e "${p}[${h}+${p}] Berhasil menginstal John the ripper.${r}"
exit 0
