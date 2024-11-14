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

# Cek koneksi internet
echo "[*] Mengecek koneksi internet..."
sleep 3
if ! ping -c 1 8.8.8.8 >> /dev/null 2>&1; then
        echo "[-] Anda tidak memiliki koneksi internet."
        exit 1
fi

echo "[+] Anda memiliki koneksi internet."

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
echo "[*] Memperbarui repositori Linux..."
sleep 3
apt-get update -y >> /dev/null 2>&1
if [[ $? -ne 0 ]]; then
        echo "[-] Gagal memperbarui repositori Linux."
        exit 1
fi

echo "[+] Berhasil memperbarui repositori Linux."

# Menginstal dependensi yang diperlukan John The Ripper
echo "[*] Menginstal dependensi yang diperlukan John The Ripper..."
sleep 3
for dependensi in "${daftar_dependensi[@]}"; do
      echo "[*] Menginstal ${dependensi}..."
      sleep 3
      apt-get install "${dependensi}" -y >> /dev/null 2>&1
      if [[ $? -ne 0 ]]; then
              echo "[-] Gagal menginstal ${dependensi}."
              exit 1
      fi

      echo "[+] Berhasil menginstal ${dependensi}."
done

# Mengkloning John The Ripper dari Github
echo "[*] Mengkloning John The Ripper dari Github..."
sleep 3
cd "${lokasi_instalasi_john}"
git clone https://github.com/openwall/john >> /dev/null 2>&1
if [[ $? -ne 0 ]]; then
        echo "[-] Gagal mengkloning John The Ripper dari Github."
        exit 1

fi

echo "[+] Berhasil mengkloning John The Ripper dari Github."

# Folder saat ini '/usr/share'
# Masuk ke folder 'src' dari John the ripper
cd john/src

# Membuat Makefile untuk menginstal John The Ripper...
echo "[*] Membuat Makefile..."
sleep 3
./configure
if [[ $? -ne 0 ]]; then
        echo "[-] Gagal membuat Makefile."
        exit 1
fi

echo "[+] Berhasil membuat Makefile."

# Membangun ulang John The Ripper
echo "[*] Membangun ulang John The Ripper..."
sleep 3
make -s clean && make -sj8
if [[ $? -ne 0 ]]; then
        echo "[-] Gagal membangun ulang John The Ripper."
        exit 1
fi

echo "[+] Berhasil membangun ulang John The Ripper."

# Menginstal John The Ripper
echo "[*] Menginstal John The Ripper..."
sleep 3
make install
if [[ $? -ne 0 ]]; then
        echo "[-] Gagal menginstal John The Ripper."
        exit 1
fi

echo "[+] Berhasil menginstal John the ripper."
# John The Ripper 
alias john="/usr/share/john/run/john"
echo "export PATH=$PATH:/usr/share/john/run" >> ~/.bashrc

# Memuat ulang (reload) file konfigurasi shell '~/.bashrc'
source ~/.bashrc
exit 0
