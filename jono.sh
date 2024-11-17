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
        echo -e "${p}[${m}-${p}] ${p}Script ini harus dijalankan sebagai root.${r}"
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
echo ""
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
echo ""

sleep 3

# Mengecek sistem operasi
echo -e "${p}[${b}*${p}] Mengecek sistem operasi...${r}"
sleep 3
sistem_operasi=$(uname -s)
if [[ "${sistem_operasi}" != "Linux" ]]; then
        echo -e "${p}[${m}-${p}] Sistem operasi Anda tidak mendukung untuk menjalankan program Jono.${r}"
        exit 1
fi

# Mengecek ID Linux
file_id_linux="/etc/os-release"
if [[ ! -f "${file_id_linux}" ]]; then
        echo -e "${p}[${m}-${p}] File '${file_id_linux}' tidak ditemukan. Sistem operasi Anda tidak mendukung untuk menjalankan program Jono.${r}"
        exit 1
fi
. "${file_id_linux}"
id_linux=$ID
if [[ "${id_linux}" != "debian" && "${id_linux}" != "ubuntu" && "${id_linux}" != "kali" ]]; then
        echo -e "${p}[${m}-${p}] Sistem operasi Anda tidak mendukung untuk menjalankan program Jono.${r}"
        exit 1
fi

echo -e "${p}[${h}+${p}] Sistem operasi Anda: ${sistem_operasi} (${id_linux}).${r}"

# Mengecek alat
daftar_alat=(
        "john"
        "zip2john"
        "rar2john"
        "7z2john"
        "pdf2john"
        "office2john"
)

# Alat yang belum terinstal
daftar_alat_belum_terinstal=()

for alat in "${daftar_alat[@]}"; do
        echo -e "${p}[${b}*${p}] Mengecek '${alat}'...${r}"
        sleep 3
        command -v "${alat}" >> /dev/null 2>&1
        if [[ $? -ne 0 ]]; then
                echo -e "${p}[${m}-${p}] '${alat}' belum terinstal.${r}"
                daftar_alat_belum_terinstal+=("${alat}")
        fi
        echo -e "${p}[${h}+${p}] '${alat}' sudah terinstal.${r}"
done

if [[ "${#daftar_alat_belum_terinstal[@]}" -ne 0 ]]; then
        echo "[-] Program Jono tidak dapat dijalankan karena ada beberapa alat yang belum terinstal.."
        echo ""
        echo "Alat yang belum terinstal:"
        for alat_belum_terinstal in "${daftar_alat_belum_terinstal[@]}"; do
                echo "- ${alat_belum_terinstal}"
        done
        exit 1

fi

echo ""
read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk melanjutkan...\e[0m' lanjutkan

# Utama
while true; do

        program="Jono"
        github="https://github.com/fixploit03/Jono/"
        clear

        # waktu saat ini
        waktu=$(date +"%d-%m-%Y %H:%M:%S")

        # Menu Jono
        echo ""
        echo -e "${p}[${k}${program}${p}] [${b}${waktu}${p}] [${h}${github}${p}]${r}"
        echo ""
        echo -e "${p}Daftar menu yang tersedia:${r}"
        echo ""
        echo -e "${p}-------------------------------------------------------------------${r}"
        echo -e "${p}[${k}0${p}] Keluar${r}"
        echo -e "-------------------------------------------------------------------"
        echo -e "${p}[${k}1${p}] Ekstrak hash file ZIP${r}"
        echo -e "${p}[${k}2${p}] Ekstrak hash file RAR${r}"
        echo -e "${p}[${k}3${p}] Ekstrak hash file 7z${r}"
        echo -e "${p}[${k}4${p}] Ekstrak hash file PDF${r}"
        echo -e "${p}[${k}5${p}] Ekstrak hash file Office (.docx, .xlsx, .pptx)${r}"
        echo -e "${p}-------------------------------------------------------------------${r}"
        echo -e "${p}[${k}6${p}] Pulihkan kata sandi file ZIP${r}"
        echo -e "${p}[${k}7${p}] Pulihkan kata sandi file RAR${r}"
        echo -e "${p}[${k}8${p}] Pulihkan kata sandi file 7z${r}"
        echo -e "${p}[${k}9${p}] Pulihkan kata sandi file PDF${r}"
        echo -e "${p}[${k}10${p}] Pulihkan kata sandi file Office (.docx, .xlsx, .pptx)${r}"
        echo -e "${p}-------------------------------------------------------------------${r}"
        echo -e "${p}[${k}11${p}] Tentang${r}"
        echo -e "${p}-------------------------------------------------------------------${r}"

        while true; do
                read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Pilih menu: '  pilih_menu
                if [[  "${pilih_menu}" == "0" ]]; then
                        exit 0
                elif [[ "${pilih_menu}" == "1" ]]; then
                        while true; do
                                read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file ZIP: ' file_zip
                                echo -e "${p}[${b}*${p}] Mengecek file ZIP '${file_zip}'...${r}"
                                sleep 3
                                if [[ -z "${file_zip}" ]]; then
                                        echo -e "${p}[${m}-${p}] File ZIP tidak boleh kosong.${r}"
                                        continue
                                fi

                                if [[ ! -f "${file_zip}" ]]; then
                                        echo -e "${p}[${m}-${p}] File ZIP '${file_zip}' tidak ditemukan.${r}"
                                        continue
                                fi

                                if [[ "${file_zip##*.}" != "zip" ]]; then
                                        echo -e "${p}[${m}-${p}] File '${file_zip}' bukan file ZIP.${r}"
                                        continue
                                fi

                                echo -e "${p}[${h}+${p}] File ZIP '${file_zip}' ditemukan.${r}"
                                echo -e "${p}[${b}*${p}] Mengekstrak hash file ZIP '${file_zip}'...${r}"
                                sleep 3
                                hash_file_zip=$(zip2john "${file_zip}")
                                nama_file_zip=$(basename "${file_zip}")
                                nama_file_hash="${lokasi_file_hash}/${nama_file_zip}.john"
                                echo "${hash_file_zip}" >> "${nama_file_hash}"
                                if [[ -f "${nama_file_hash}" ]]; then
                                        if [[ $(cat "${nama_file_hash}" | grep -o "zip" || cat "${nama_file_hash}" | grep -o "pkzip") ]]; then
                                                echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file ZIP '${file_zip}'.${r}"
                                        else
                                                echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file ZIP '${file_zip}'.${r}"
                                        fi
                                else
                                        echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file ZIP '${file_zip}'.${r}"
                                fi
                                echo ""
                                read -p "Tekan [Enter] untuk melanjutkan..."
                                break

                        done
                        break
                else
                        echo -e "${p}[${m}-${p}] Menu '${pilih_menu}' tidak tersedia. Silahkan pilih kembali.${r}"
                        continue
                fi
        done
done
