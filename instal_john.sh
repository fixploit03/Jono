#!/bin/bash
#-------------------------------------------
# [instal_jono.sh]
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

# Fungsi untuk mengecek root
function mengecek_root(){
	if [[ "$EUID" -ne 0 ]]; then
        	echo -e "${p}[${m}-${p}] ${p}Program ini harus dijalankan sebagai root.${r}"
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

        # Nama distro 
	distro=$NAME

	# Distro Hacking
	distro_hacking=(
		"Kali GNU/Linux"
		"Parrot Security"
	)

	# Distro non Hacking
	distro_non_hacking=(
		"Debian GNU/Linux"
		"Ubuntu"
		"Linux Mint"
	)

        distro_ditemukan=false
	
        # Cek di distro_hacking
        for dh in "${distro_hacking[@]}"; do
                if [[ "${distro}" == "${dh}" ]]; then
                        bash "installer/installer_jono_kali.sh"
                        distro_ditemukan=true
                        break
                fi
        done

        # Jika belum ditemukan, cek di distro_non_hacking
        if [[ "${distro_ditemukan}" == false ]]; then
                for dnh in "${distro_non_hacking[@]}"; do
                        if [[ "${distro}" == "${dnh}" ]]; then
                                bash "installer/installer_jono_deb_ubuntu.sh"
                                distro_ditemukan=true
                                break
                        fi
                done
        fi

        # Jika tidak ditemukan
        if [[ "${distro_ditemukan}" == false ]]; then
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
