#!/bin/bash
# Jangan diutak-atik. GW CAPE!!!

# Variabel warna
m="\e[1;31m" # Merah
h="\e[1;32m" # Hijau 
b="\e[1;34m" # Biru 
p="\e[1;37m" # Putih 
r="\e[0m"    # Reset 

# Lokasi folder untuk menyimpan John The Ripper
lokasi_instalasi_john="/usr/share"

# Cek root
if [[ "$EUID" -ne 0 ]]; then
        echo -e "${m}[-] ${p}Script ini harus dijalankan sebagai root.${r}"
        exit 1
fi

# Menampilkan banner
echo ""
echo -e "${p}╦╔╗╔╔═╗╔╦╗╔═╗╦  ╦  ╔═╗╦═╗  ${m}╦╔═╗╔╗╔╔═╗${r}"
echo -e "${p}║║║║╚═╗ ║ ╠═╣║  ║  ║╣ ╠╦╝  ${m}║║ ║║║║║ ║${r}"
echo -e "${p}╩╝╚╝╚═╝ ╩ ╩ ╩╩═╝╩═╝╚═╝╩╚═ ${m}╚╝╚═╝╝╚╝╚═╝${r}"
echo -e "${p}Selamat datang di menu installer Jono${r}"

# Cek koneksi internet
echo -e "${b}[*] ${p}Mengecek koneksi internet...${r}"
sleep 3
if ! ping -c 1 8.8.8.8 >> /dev/null 2>&1; then
        echo -e "${m}[-] ${p}Anda tidak memiliki koneksi internet.${r}"
        exit 1
fi

echo -e "${h}[+] ${p}Anda memiliki koneksi internet.${r}"

# Daftar dependensi yang diperlukan untuk menginstal John the Ripper
daftar_dependensi=(
        "cmake"
        "bison"
        "flex"
        "libicu-dev"
        "build-essential"
        "libssl-dev"
        "git"
        "zlib1g-dev"
        "yasm"
        "libgmp-dev"
        "libpcap-dev"
        "pkg-config"
        "libbz2-dev"
)

# Memperbarui repositori Linux
echo -e "${b}[*] ${p}Memperbarui repositori Linux...${r}"
sleep 3
apt-get update -y >> /dev/null 2>&1
if [[ $? -ne 0 ]]; then
        echo -e "${m}[-] ${p}Gagal memperbarui repositori Linux.${r}"
        exit 1
fi

echo -e "${h}[+] ${p}Berhasil memperbarui repositori Linux.${r}"

# Menginstal dependensi yang diperlukan John The Ripper
echo -e "${b}[*] ${p}Menginstal dependensi yang diperlukan John The Ripper...${r}"
sleep 3
for dependensi in "${daftar_dependensi[@]}"; do
      echo -e "${b}[*] Menginstal '${dependensi}'...${r}"
      sleep 3
      apt-get install "${dependensi}" -y >> /dev/null 2>&1
      if [[ $? -ne 0 ]]; then
              echo -e "${m}[-] ${p}Gagal menginstal '${dependensi}'.${r}"
              exit 1
      fi

      echo -e "${h}[+] ${p}Berhasil menginstal '${dependensi}'.${r}"
done

# Mengkloning John The Ripper dari Github
echo -e "${b}[*] ${p}Mengkloning John The Ripper dari Github...${r}"
sleep 3
cd "${lokasi_instalasi_john}"
git clone https://github.com/openwall/john >> /dev/null 2>&1
if [[ $? -ne 0 ]]; then
        echo -e "${m}[-] ${p}Gagal mengkloning John The Ripper dari Github.${r}"
        exit 1

fi

echo -e "${h}[+] ${p}Berhasil mengkloning John The Ripper dari Github.${r}"

# Folder saat ini '/usr/share'
# Masuk ke folder 'src' dari John the ripper
cd john/src

# Membuat Makefile untuk menginstal John The Ripper...
echo -e "${b}[*] ${p}Membuat Makefile...${r}"
sleep 3
./configure
if [[ $? -ne 0 ]]; then
        echo -e "${m}[-] ${p}Gagal membuat Makefile.${r}"
        exit 1
fi

echo -e "${h}[+] ${p}Berhasil membuat Makefile.${r}"

# Membangun ulang John The Ripper
echo -e "${b}[*] ${p}Membangun ulang John The Ripper...${r}"
sleep 3
make -s clean && make -sj8
if [[ $? -ne 0 ]]; then
        echo -e "${m}[-] ${p}Gagal membangun ulang John The Ripper.${r}"
        exit 1
fi

echo -e "${h}[+] ${p}Berhasil membangun ulang John The Ripper.${r}"

# Menginstal John The Ripper
echo -e "${b}[*] ${p}Menginstal John The Ripper...${r}"
sleep 3
make install
if [[ $? -ne 0 ]]; then
        echo -e "${m}[-] ${p}Gagal menginstal John The Ripper.${r}"
        exit 1
fi

echo -e "${h}[+] ${p}Berhasil menginstal John the ripper.${r}"
# John The Ripper 
alias john="/usr/share/john/run/john"
echo "export PATH=$PATH:/usr/share/john/run" >> ~/.bashrc

# Memuat ulang (reload) file konfigurasi shell '~/.bashrc'
source ~/.bashrc
exit 0
