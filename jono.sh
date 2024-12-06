#!/bin/bash
#-------------------------------------------
# [jono.sh]
# File ini merupakan bagian dari proyek Jono
# Dibuat oleh: fixploit03
#-------------------------------------------
# Mau ngapain sih Broh ^_^

# Variabel warna
m="\e[1;31m" # Merah
p="\e[1;37m" # Putih
r="\e[0m"    # Reset

# Fungsi untuk mengecek root
function mengecek_root(){
	if [[ "$EUID" -ne 0 ]]; then
        	echo -e "${p}[${m}-${p}] ${p}Program ini harus dijalankan sebagai root.${r}"
	        exit 1
	fi
}

# Fungsi untuk mengecek nilai Hash
function cek_hash(){
# File dan Hash
        deb="src/jono_deb_ubuntu.sh"
        kali="src/jono_kali.sh"
        hash_deb="791e1b02f2411156e11d5c637433ffd1"
        hash_kali="9688bd0f4288bda758c3610f7839590c"

        if [[ $(md5sum "${deb}" | awk '{print $1}') != "${hash_deb}" || $(md5sum "${kali}" | awk '{print $1}') != "${hash_kali}" ]]; then
          	echo -e "${p}[${m}-${p}] Jangan di recode Broh! kalo mau berkontribusi aja :).${r}"
        	exit 1
        fi
}

# Fungsi untuk mengecek sistem operasi
function mengecek_sistem_operasi(){
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
	if [[ "${id_linux}" == "kali" ]]; then
		bash "src/jono_kali.sh"
	elif [[ "${id_linux}" == "debian" || "${id_linux}" == "ubuntu" ]]; then
		bash "src/jono_deb_ubuntu.sh"
	else
	        echo -e "${p}[${m}-${p}] Sistem operasi Anda tidak mendukung untuk menjalankan program Jono.${r}"
	        exit 1
	fi
}

# Fungsi utama
function utama(){
	# Memanggil fungsi mengecek_root
	mengecek_root
	# Memanggil fungsi mengecek_sistem_operasi
	mengecek_sistem_operasi
}

# Memanggil fungsi utama
utama
