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
k="\e[1;33m" # Kuning
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

# Membuat folder untuk menyimpan file hash
if [[ ! -d "${lokasi_file_hash}" ]]; then
        mkdir -p "${lokasi_file_hash}"
fi

# Membersihkan layar Terminal
clear

# Menampilkan kata-kata peringatan
echo -e "${b}Selamat datang di program Jono${r}"
echo -e ""
echo -e "${p}Jono adalah program Bash sederhana yang dirancang untuk melakukan cracking${r}"
echo -e "${p}terhadap kata sandi file ZIP, RAR, 7Z, PDF, dan file Office (docx, xlsx, pptx)."
echo -e "${p}Menggunakan John The Ripper.${r}"
echo -e ""
echo -e "${k}Peringatan${r}"
echo -e "${p}----------${r}"
echo -e ""
echo -e "${p}Program ini dirancang hanya untuk tujuan pendidikan dan penelitian yang sah.${r}"
echo -e "${p}Dilarang keras menggunakan program ini untuk kegiatan ilegal, merusak,${r}"
echo -e "${p}atau tanpa izin pemilik file. Pengguna bertanggung jawab penuh atas segala${r}"
echo -e "${p}konsekuensi hukum yang mungkin timbul dari penggunaan program ini. Pastikan${r}"
echo -e "${p}untuk selalu mematuhi peraturan dan etika yang berlaku di wilayah Anda.${r}"
echo -e ""

sleep 3

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

# Mengecek alat
daftar_alat=(
        "john"
        "zip2john"
        "rar2john"
        "7z2john"
        "pdf2john"
        "office2john"
)

for alat in "${daftar_alat[@]}"; do
        echo "[*] Mengecek '${alat}'"
        sleep 3
        command -v "${alat}" >> /dev/null 2>&1
        if [[ $? -ne 0 ]]; then
                echo "[-] '${alat}' belum diinstal. Instal dengan mengetikkan perintah 'bash instal.sh'."
        fi
done
