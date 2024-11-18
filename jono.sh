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

# Fungsi untuk mengecek root
function mengecek_root(){
	if [[ "$EUID" -ne 0 ]]; then
        	echo -e "${p}[${m}-${p}] ${p}Script ini harus dijalankan sebagai root.${r}"
	        exit 1
	fi
}

# Fungsi untuk membuat folder 'file_hash'
function membuat_folder_file_hash(){
	# Lokasi folder untuk menyimpan file hash
	lokasi_file_hash="file_hash"

	# Membuat folder untuk menyimpan file hash
	if [[ ! -d "${lokasi_file_hash}" ]]; then
	        mkdir -p "${lokasi_file_hash}"
	fi
}

# Fungsi untuk membersihkan layar terminal
function membersihkan_layar_terminal(){
	clear
}

# Fungsi untuk menampilkan kata kata peringatan
function menampilkan_kata_kata_peringatan(){
        membersihkan_layar_terminal
	echo ""
	echo -e "${b}Selamat datang di Jono${r}"
	echo -e "${p}-------------------${r}"
	echo ""
	echo -e "${p}Jono adalah program Bash sederhana yang dirancang untuk memulihkan kata sandi${r}"
	echo -e "${p}file ZIP, RAR, 7Z, PDF, dan file Office (.docx, .xlsx, .pptx). Menggunakan${r}"
	echo -e "${p}John The Ripper.${r}"
	echo ""
}

# Fugsi untuk tunggu selama 3 detik
function tunggu(){
	sleep 3
}

# Fungsi untuk mengecek sistem operasi
function mengecek_sistem_operasi(){
	echo -e "${p}[${b}*${p}] Mengecek sistem operasi...${r}"
	tunggu
	sistem_operasi=$(uname -s)
	if [[ "${sistem_operasi}" != "Linux" ]]; then
	        echo -e "${p}[${m}-${p}] Sistem operasi Anda tidak mendukung untuk menjalankan Jono.${r}"
	        exit 1
	fi

	# Mengecek ID Linux
	file_id_linux="/etc/os-release"
	if [[ ! -f "${file_id_linux}" ]]; then
	        echo -e "${p}[${m}-${p}] File '${file_id_linux}' tidak ditemukan. Sistem operasi Anda tidak mendukung untuk menjalankan Jono.${r}"
	        exit 1
	fi
	. "${file_id_linux}"
	id_linux=$ID
	if [[ "${id_linux}" != "debian" && "${id_linux}" != "ubuntu" && "${id_linux}" != "kali" ]]; then
	        echo -e "${p}[${m}-${p}] Sistem operasi Anda tidak mendukung untuk menjalankan Jono.${r}"
	        exit 1
	fi

	echo -e "${p}[${h}+${p}] Sistem operasi Anda: ${sistem_operasi} (${id_linux}).${r}"
}

# Fungsi untuk mengecek alat
function mengecek_alat(){
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

	echo -e "${p}[${b}*${p}] Mengecek alat-alat yang dibutuhkan oleh Jono...${r}"
	tunggu

	for alat in "${daftar_alat[@]}"; do
	        echo -e "${p}[${b}*${p}] Mengecek '${alat}'...${r}"
        	tunggu
	        command -v "${alat}" >> /dev/null 2>&1
        	if [[ $? -ne 0 ]]; then
	                echo -e "${p}[${m}-${p}] '${alat}' belum terinstal.${r}"
        	        daftar_alat_belum_terinstal+=("${alat}")
	        else
        	        echo -e "${p}[${h}+${p}] '${alat}' sudah terinstal.${r}"
	        fi
	done

	if [[ "${#daftar_alat_belum_terinstal[@]}" -ne 0 ]]; then
        	echo -e "${p}[${m}-${p}] Jono tidak dapat dijalankan karena ada beberapa alat yang belum terinstal..${r}"
	        echo ""
	        echo -e "${p}Alat yang belum terinstal:${r}"
        	for alat_belum_terinstal in "${daftar_alat_belum_terinstal[@]}"; do
                	echo -e "${p}- ${alat_belum_terinstal}${r}"
	        done
	        exit 1

	fi

	echo -e "${p}[${h}+${p}] Semua alat yang dibutuhkan oleh Jono sudah terinstal.${r}"
	echo ""
	read -p l$'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk melanjutkan...\e[0m'
}

# Fungsi untuk keluar program
function keluar(){
	echo "[*] Semoga harimu menyenangkan ^_^" 
	exit 1
}

# Fungsi untuk memasukkan file ZIP
function memasukkan_file_zip(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file ZIP: ' file_zip
                echo -e "${p}[${b}*${p}] Mengecek file ZIP '${file_zip}'...${r}"
                tunggu
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
		break
	done
}

# Fungsi untuk memasukkan file RAR
function memasukkan_file_rar(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file RAR: ' file_rar
                echo -e "${p}[${b}*${p}] Mengecek file RAR '${file_rar}'...${r}"
                tunggu
                if [[ -z "${file_rar}" ]]; then
                	echo -e "${p}[${m}-${p}] File RAR tidak boleh kosong.${r}"
                        continue
                fi
                if [[ ! -f "${file_rar}" ]]; then
                	echo -e "${p}[${m}-${p}] File RAR '${file_rar}' tidak ditemukan.${r}"
                        continue
                fi
                if [[ "${file_rar##*.}" != "rar" ]]; then
                	echo -e "${p}[${m}-${p}] File '${file_rar}' bukan file RAR.${r}"
                        continue
                fi
                echo -e "${p}[${h}+${p}] File RAR '${file_rar}' ditemukan.${r}"
		break
	done
}

# Fungsi untuk memasukkan file 7z
function memasukkan_file_7z(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file 7z: ' file_7z
                echo -e "${p}[${b}*${p}] Mengecek file 7z '${file_7z}'...${r}"
                tunggu
                if [[ -z "${file_7z}" ]]; then
                	echo -e "${p}[${m}-${p}] File 7z tidak boleh kosong.${r}"
                        continue
                fi
                if [[ ! -f "${file_7z}" ]]; then
                	echo -e "${p}[${m}-${p}] File 7z '${file_7z}' tidak ditemukan.${r}"
                        continue
                fi
                if [[ "${file_7z##*.}" != "7z" ]]; then
                	echo -e "${p}[${m}-${p}] File '${file_7z}' bukan file 7z.${r}"
                        continue
                fi
                echo -e "${p}[${h}+${p}] File 7z '${file_7z}' ditemukan.${r}"
		break
	done
}


# Fungsi untuk memasukkan file PDF
function memasukkan_file_pdf(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file PDF: ' file_pdf
                echo -e "${p}[${b}*${p}] Mengecek file PDF '${file_pdf}'...${r}"
                tunggu
                if [[ -z "${file_pdf}" ]]; then
                	echo -e "${p}[${m}-${p}] File PDF tidak boleh kosong.${r}"
                        continue
                fi
                if [[ ! -f "${file_pdf}" ]]; then
                       	echo -e "${p}[${m}-${p}] File PDF '${file_pdf}' tidak ditemukan.${r}"
                continue
               	fi
                if [[ "${file_pdf##*.}" != "pdf" ]]; then
                	echo -e "${p}[${m}-${p}] File '${file_pdf}' bukan file PDF.${r}"
                	continue
                fi
                echo -e "${p}[${h}+${p}] File PDF '${file_pdf}' ditemukan.${r}"
		break
	done
}

# Fungsi untuk memasukkan file Office
function memasukkan_file_office(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file Office (.docx, .xlsx, .pptx): ' file_office
                echo -e "${p}[${b}*${p}] Mengecek file Office '${file_office}'...${r}"
                tunggu
                if [[ -z "${file_office}" ]]; then
                	echo -e "${p}[${m}-${p}] File Office tidak boleh kosong.${r}"
                        continue
                fi
                if [[ ! -f "${file_office}" ]]; then
                	echo -e "${p}[${m}-${p}] File Office '${file_office}' tidak ditemukan.${r}"
                        continue
                fi
	        if [[ "${file_office##*.}" != "docx" && "${file_office##*.}" != "xlsx" && "${file_office##*.}" != "pptx" ]]; then
        		echo -e "${m}[-] ${p}File '${file_office}' bukan file Office.${r}"
                	continue
                fi
               	echo -e "${p}[${h}+${p}] File Office '${file_office}' ditemukan.${r}"
		break
	done
}


# Fungsi untuk mengekstrak hash file ZIP
function ekstrak_hash_file_zip(){
	echo -e "${p}[${b}*${p}] Mengekstrak hash file ZIP '${file_zip}'...${r}"
        tunggu
        hash_file_zip=$(zip2john "${file_zip}" 2>/dev/null)
        nama_file_zip=$(basename "${file_zip}")
        nama_file_hash_file_zip="${lokasi_file_hash}/${nama_file_zip}.john"
        echo "${hash_file_zip}" >> "${nama_file_hash_file_zip}"
        if [[ -f "${nama_file_hash_file_zip}" ]]; then
                if [[ $(cat "${nama_file_hash_file_zip}" | grep -o "zip" || cat "${nama_file_hash_file_zip}" | grep -o "pkzip") ]]; then
                        echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file ZIP '${file_zip}'.${r}"
                        echo -e "${p}[${h}+${p}] File hash file ZIP '${file_zip}' disimpan di: ${nama_file_hash_file_zip}.${r}"
                else
                        echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file ZIP '${file_zip}'.${r}"
                fi
        else
        	echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file ZIP '${file_zip}'.${r}"
        fi
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
	menampilkan_menu
}

# Fungsi untuk mengekstrak hash file RAR
function ekstrak_hash_file_rar(){
	echo -e "${p}[${b}*${p}] Mengekstrak hash file RAR '${file_rar}'...${r}"
        tunggu
        hash_file_rar=$(rar2john "${file_rar}" 2>/dev/null)
        nama_file_rar=$(basename "${file_rar}")
        nama_file_hash_file_rar="${lokasi_file_hash}/${nama_file_rar}.john"
        echo "${hash_file_rar}" >> "${nama_file_hash_file_rar}"
        if [[ -f "${nama_file_hash_file_rar}" ]]; then
        	if [[ $(cat "${nama_file_hash_file_rar}" | grep -o "rar5") ]]; then
                     	echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file RAR '${file_rar}'.${r}"
                        echo -e "${p}[${h}+${p}] File hash file RAR '${file_rar}' disimpan di: ${nama_file_hash_file_rar}.${r}"
                else
             	        echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file RAR '${file_rar}'.${r}"
                fi
       	else
               	echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file RAR '${file_rar}'.${r}"
        fi
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
        menampilkan_menu
 }

# Fungsi untuk mengekstrak hash file 7z
function ekstrak_hash_file_7z(){
        echo -e "${p}[${b}*${p}] Mengekstrak hash file 7z '${file_7z}'...${r}"
        tunggu
        hash_file_7z=$(7z2john "${file_7z}" 2>/dev/null)
        nama_file_7z=$(basename "${file_7z}")
        nama_file_hash_file_7z="${lokasi_file_hash}/${nama_file_7z}.john"
        echo "${hash_file_7z}" >> "${nama_file_hash_file_7z}"
        if [[ -f "${nama_file_hash_file_7z}" ]]; then
                if [[ $(cat "${nama_file_hash_file_7z}" | grep -o "7z") ]]; then
                	echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file 7z '${file_7z}'.${r}"
                        echo -e "${p}[${h}+${p}] File hash file 7z '${file_7z}' disimpan di: ${nama_file_hash_file_7z}.${r}"
                else
                        echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file 7z '${file_7z}'.${r}"
                fi
        else
                echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file 7z '${file_7z}'.${r}"
        fi
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
	menampilkan_menu
}

# Fungsi untuk mengekstrak hash file PDF
function ekstrak_hash_file_pdf(){
	echo -e "${p}[${b}*${p}] Mengekstrak hash file PDF '${file_pdf}'...${r}"
        tunggu
        hash_file_pdf=$(pdf2john "${file_pdf}")
        nama_file_pdf=$(basename "${file_pdf}")
        nama_file_hash_file_pdf="${lokasi_file_hash}/${nama_file_pdf}.john"
        echo "${hash_file_pdf}" >> "${nama_file_hash_file_pdf}"
        if [[ -f "${nama_file_hash_file_pdf}" ]]; then
        	if [[ $(cat "${nama_file_hash_file_pdf}" | grep -o "pdf") ]]; then
                	echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file PDF '${file_pdf}'.${r}"
                        echo -e "${p}[${h}+${p}] File hash file PDF '${file_pdf}' disimpan di: ${nama_file_hash_file_pdf}.${r}"
                else
                       	echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file PDF '${file_pdf}'.${r}"
                fi
      	else
       		echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file PDF '${file_pdf}'.${r}"
        fi
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
	menampilkan_menu
}

# Fungsi uentuk mengekstrak hash file Office
function ekstrak_hash_file_office(){
	echo -e "${p}[${b}*${p}] Mengekstrak hash file Office '${file_office}'...${r}"
        tunggu
        hash_file_office=$(office2john "${file_office}")
        nama_file_office=$(basename "${file_office}")
        nama_file_hash_file_office="${lokasi_file_hash}/${nama_file_office}.john"
        echo "${hash_file_office}" >> "${nama_file_hash_file_office}"
        if [[ -f "${nama_file_hash_file_office}" ]]; then
        	if [[ $(cat "${nama_file_hash_file_office}" | grep -o "office") ]]; then
                	echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file Office '${file_office}'.${r}"
                        echo -e "${p}[${h}+${p}] File hash file Office '${file_office}' disimpan di: ${nama_file_hash_file_office}.${r}"
                else
                        echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file Office '${file_office}'.${r}"
                fi
	else
                echo -e "${p}[${m}-${p}] Gagal mengekstrak hash file Office '${file_office}'.${r}"
        fi
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
	menampilkan_menu
}

# Fungsi untuk memasukkan file hash file ZIP
function memasukkan_file_hash_file_zip(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file hash file ZIP: ' file_hash_file_zip
                echo -e "${p}[${b}*${p}] Mengecek file hash file ZIP '${file_hash_file_zip}'...${r}"
                tunggu
               	if [[ -z "${file_hash_file_zip}" ]]; then
                	echo -e "${p}[${m}-${p}] File hash file ZIP tidak boleh kosong.${r}"
                        continue
               	fi
                if [[ ! -f "${file_hash_file_zip}" ]]; then
                	echo -e "${p}[${m}-${p}] File hash file ZIP '${file_hash_file_zip}' tidak ditemukan.${r}"
                        continue
                fi
                if [[ "${file_hash_file_zip##*.}" != "john" ]]; then
                	echo -e "${p}[${m}-${p}] File '${file_hash_file_zip}' bukan file hash.${r}"
                        continue
                fi
		if [[ $(cat "${file_hash_file_zip}" | grep -o "zip" || cat "${file_hash_file_zip}" | grep -o "pkzip") ]]; then
	                echo -e "${p}[${h}+${p}] File hash file ZIP '${file_hash_file_zip}' ditemukan.${r}"
		else
			echo -e "${p}[${m}-${p}] Format file hash file ZIP '${file_hash_file_zip}' tidak valid.${r}"
			continue
		fi
		break
	done
}

# Fungsi untuk memasukkan file hash file RAR
function memasukkan_file_hash_file_rar(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file hash file RAR: ' file_hash_file_rar
                echo -e "${p}[${b}*${p}] Mengecek file hash file RAR '${file_hash_file_rar}'...${r}"
                tunggu
               	if [[ -z "${file_hash_file_rar}" ]]; then
                	echo -e "${p}[${m}-${p}] File hash file RAR tidak boleh kosong.${r}"
                        continue
               	fi
                if [[ ! -f "${file_hash_file_rar}" ]]; then
                	echo -e "${p}[${m}-${p}] File hash file RAR '${file_hash_file_rar}' tidak ditemukan.${r}"
                        continue
                fi
                if [[ "${file_hash_file_rar##*.}" != "john" ]]; then
                	echo -e "${p}[${m}-${p}] File '${file_hash_file_rar}' bukan file hash.${r}"
                        continue
                fi
		if [[ $(cat "${file_hash_file_rar}" | grep -o "rar5") ]]; then
	                echo -e "${p}[${h}+${p}] File hash file RAR '${file_hash_file_rar}' ditemukan.${r}"
		else
			echo -e "${p}[${m}-${p}] Format file hash file RAR '${file_hash_file_rar}' tidak valid.${r}"
			continue
		fi
		break
	done
}

# Fungsi untuk memasukkan file hash file 7z
function memasukkan_file_hash_file_7z(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file hash file 7z: ' file_hash_file_7z
                echo -e "${p}[${b}*${p}] Mengecek file hash file 7z '${file_hash_file_7z}'...${r}"
                tunggu
               	if [[ -z "${file_hash_file_7z}" ]]; then
                	echo -e "${p}[${m}-${p}] File hash file 7z tidak boleh kosong.${r}"
                        continue
               	fi
                if [[ ! -f "${file_hash_file_7z}" ]]; then
                	echo -e "${p}[${m}-${p}] File hash file 7z '${file_hash_file_7z}' tidak ditemukan.${r}"
                        continue
                fi
                if [[ "${file_hash_file_7z##*.}" != "john" ]]; then
                	echo -e "${p}[${m}-${p}] File '${file_hash_file_7z}' bukan file hash.${r}"
                        continue
                fi
		if [[ $(cat "${file_hash_file_7z}" | grep -o "7z") ]]; then
	                echo -e "${p}[${h}+${p}] File hash file 7z '${file_hash_file_7z}' ditemukan.${r}"
		else
			echo -e "${p}[${m}-${p}] Format file hash file 7z '${file_hash_file_7z}' tidak valid.${r}"
			continue
		fi
		break
	done
}

# Fungsi untuk memasukkan file hash file PDF
function memasukkan_file_hash_file_pdf(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file hash file PDF: ' file_hash_file_pdf
                echo -e "${p}[${b}*${p}] Mengecek file hash file PDF '${file_hash_file_pdf}'...${r}"
                tunggu
               	if [[ -z "${file_hash_file_pdf}" ]]; then
                	echo -e "${p}[${m}-${p}] File hash file PDF tidak boleh kosong.${r}"
                        continue
               	fi
                if [[ ! -f "${file_hash_file_pdf}" ]]; then
                	echo -e "${p}[${m}-${p}] File hash file PDF '${file_hash_file_pdf}' tidak ditemukan.${r}"
                        continue
                fi
                if [[ "${file_hash_file_pdf##*.}" != "john" ]]; then
                	echo -e "${p}[${m}-${p}] File '${file_hash_file_pdf}' bukan file hash.${r}"
                        continue
                fi
		if [[ $(cat "${file_hash_file_pdf}" | grep -o "pdf") ]]; then
	                echo -e "${p}[${h}+${p}] File hash file PDF '${file_hash_file_pdf}' ditemukan.${r}"
		else
			echo -e "${p}[${m}-${p}] Format file hash file PDF '${file_hash_file_pdf}' tidak valid.${r}"
			continue
		fi
		break
	done
}

# Fungsi untuk memasukkan file hash file Office
function memasukkan_file_hash_file_office(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file hash file Office: ' file_hash_file_office
                echo -e "${p}[${b}*${p}] Mengecek file hash file Office '${file_hash_file_office}'...${r}"
                tunggu
               	if [[ -z "${file_hash_file_office}" ]]; then
                	echo -e "${p}[${m}-${p}] File hash file Office tidak boleh kosong.${r}"
                        continue
               	fi
                if [[ ! -f "${file_hash_file_office}" ]]; then
                	echo -e "${p}[${m}-${p}] File hash file Office '${file_hash_file_office}' tidak ditemukan.${r}"
                        continue
                fi
                if [[ "${file_hash_file_office##*.}" != "john" ]]; then
                	echo -e "${p}[${m}-${p}] File '${file_hash_file_office}' bukan file hash.${r}"
                        continue
                fi
		if [[ $(cat "${file_hash_file_office}" | grep -o "office") ]]; then
	                echo -e "${p}[${h}+${p}] File hash file Office '${file_hash_file_office}' ditemukan.${r}"
		else
			echo -e "${p}[${m}-${p}] Format file hash file Office '${file_hash_file_office}' tidak valid.${r}"
			continue
		fi
		break
	done
}


# Fungsi untuk memasukkan file Wordlist
function memasukkan_file_wordlist(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file Wordlist: ' file_wordlist
                echo -e "${p}[${b}*${p}] Mengecek file Wordlist '${file_wordlist}'...${r}"
                tunggu
               	if [[ -z "${file_wordlist}" ]]; then
                	echo -e "${p}[${m}-${p}] File Wordlist tidak boleh kosong.${r}"
                        continue
               	fi
                if [[ ! -f "${file_wordlist}" ]]; then
                	echo -e "${p}[${m}-${p}] File Wordlist '${file_wordlist}' tidak ditemukan.${r}"
                        continue
                fi
                echo -e "${p}[${h}+${p}] File Wordlist '${file_wordlist}' ditemukan.${r}"
		break
	done
}

# Fungsi untuk memulihkan kata sandi file ZIP
function memulihkan_kata_sandi_file_zip(){
	pot_file_zip="pot_zip.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file ZIP...\e[0m'
	echo ""
	echo -e "${p}[${b}*${p}] Memulihkan kata sandi file ZIP '${file_zip}'...${r}"
	tunggu
	if [[ $(cat "${file_hash_file_zip}" | grep -o "pkzip") ]]; then
		format_file_zip="PKZIP"
	elif [[ $(cat "${file_hash_file_zip}" | grep -o "zip") ]]; then
		format_file_zip="ZIP"
	fi
	john --wordlist="${file_wordlist}" --format="${format_file_zip}" --pot="${pot_file_zip}" --verbosity=6 --progress-every=1 "${file_hash_file_zip}"
	if [[ -f "${pot_file_zip}" ]]; then
		if [[ $(cat "${pot_file_zip}" | grep -o ":") ]]; then
			kata_sandi_file_zip=$(cat "${pot_file_zip}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file ZIP berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_zip}${r}"
			rm "${pot_file_zip}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file ZIP gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan file Wordlist yang lain.${r}"
		fi
	else
                echo ""
		echo -e "${p}[${m}-${p}] Kata sandi file ZIP gagal dipulihkan.${r}"
		echo -e "${p}[${m}-${p}] File pot John tidak ditemukan.${r}"
	fi
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
	menampilkan_menu
}

# Fungsi untuk memulihkan kata sandi file RAR
function memulihkan_kata_sandi_file_rar(){
	pot_file_rar="pot_rar.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file RAR...\e[0m'
	echo ""
	echo -e "${p}[${b}*${p}] Memulihkan kata sandi file RAR '${file_rar}'...${r}"
	tunggu
	format_file_rar="RAR5"
	john --wordlist="${file_wordlist}" --format="${format_file_rar}" --pot="${pot_file_rar}" --verbosity=6 --progress-every=1 "${file_hash_file_rar}"
	if [[ -f "${pot_file_rar}" ]]; then
		if [[ $(cat "${pot_file_rar}" | grep -o ":") ]]; then
			kata_sandi_file_rar=$(cat "${pot_file_rar}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file RAR berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_rar}${r}"
			rm "${pot_file_rar}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file RAR gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan file Wordlist yang lain.${r}"
		fi
	else
                echo ""
		echo -e "${p}[${m}-${p}] Kata sandi file RAR gagal dipulihkan.${r}"
		echo -e "${p}[${m}-${p}] File pot John tidak ditemukan.${r}"
	fi
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
	menampilkan_menu
}

# Fungsi untuk memulihkan kata sandi file 7z
function memulihkan_kata_sandi_file_7z(){
	pot_file_7z="pot_7z.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file 7z...\e[0m'
	echo ""
	echo -e "${p}[${b}*${p}] Memulihkan kata sandi file 7z '${file_7z}'...${r}"
	tunggu
	format_file_7z="7z"
	john --wordlist="${file_wordlist}" --format="${format_file_7z}" --pot="${pot_file_7z}" --verbosity=6 --progress-every=1 "${file_hash_file_7z}"
	if [[ -f "${pot_file_7z}" ]]; then
		if [[ $(cat "${pot_file_7z}" | grep -o ":") ]]; then
			kata_sandi_file_7z=$(cat "${pot_file_7z}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file 7z berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_7z}${r}"
			rm "${pot_file_7z}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file 7z gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan file Wordlist yang lain.${r}"
		fi
	else
                echo ""
		echo -e "${p}[${m}-${p}] Kata sandi file 7z gagal dipulihkan.${r}"
		echo -e "${p}[${m}-${p}] File pot John tidak ditemukan.${r}"
	fi
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
	menampilkan_menu
}

# Fungsi untuk memulihkan kata sandi file PDF
function memulihkan_kata_sandi_file_pdf(){
	pot_file_pdf="pot_pdf.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file PDF...\e[0m'
	echo ""
	echo -e "${p}[${b}*${p}] Memulihkan kata sandi file PDF '${file_pdf}'...${r}"
	tunggu
	format_file_pdf="PDF"
	john --wordlist="${file_wordlist}" --format="${format_file_pdf}" --pot="${pot_file_pdf}" --verbosity=6 --progress-every=1 "${file_hash_file_pdf}"
	if [[ -f "${pot_file_pdf}" ]]; then
		if [[ $(cat "${pot_file_pdf}" | grep -o ":") ]]; then
			kata_sandi_file_pdf=$(cat "${pot_file_pdf}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file PDF berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_pdf}${r}"
			rm "${pot_file_pdf}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file PDF gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan file Wordlist yang lain.${r}"
		fi
	else
                echo ""
		echo -e "${p}[${m}-${p}] Kata sandi file PDF gagal dipulihkan.${r}"
		echo -e "${p}[${m}-${p}] File pot John tidak ditemukan.${r}"
	fi
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
	menampilkan_menu
}

# Fungsi untuk memulihkan kata sandi file Office
function memulihkan_kata_sandi_file_office(){
	pot_file_office="pot_office.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file ZIP...\e[0m'
	echo ""
	echo -e "${p}[${b}*${p}] Memulihkan kata sandi file Office '${file_office}'...${r}"
	tunggu
	format_file_office="Office"
	john --wordlist="${file_wordlist}" --format="${format_file_office}" --pot="${pot_file_office}" --verbosity=6 --progress-every=1 "${file_hash_file_office}"
	if [[ -f "${pot_file_office}" ]]; then
		if [[ $(cat "${pot_file_office}" | grep -o ":") ]]; then
			kata_sandi_file_office=$(cat "${pot_file_office}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file Office berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_office}${r}"
			rm "${pot_file_office}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file Office gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan file Wordlist yang lain.${r}"
		fi
	else
                echo ""
		echo -e "${p}[${m}-${p}] Kata sandi file Office gagal dipulihkan.${r}"
		echo -e "${p}[${m}-${p}] File pot John tidak ditemukan.${r}"
	fi
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
	menampilkan_menu
}

# Fungsi untuk menampilkan menu yang tersedia
function menampilkan_menu(){
	# Tentang program
	program="Jono"
        github="https://github.com/fixploit03/Jono/"

	membersihkan_layar_terminal

        # waktu saat ini
        waktu=$(date +"%d-%m-%Y %H:%M:%S")

        # Menu yang tersedia
        echo ""
        echo -e "${p}[${k}${program}${p}] [${b}${waktu}${p}] [${h}${github}${p}]${r}"
        echo ""
        echo -e "${p}Daftar menu yang tersedia:${r}"
        echo ""
        echo -e "${p}------------------------------------------------------------------${r}"
        echo -e "${p}[${k}0${p}] Keluar${r}"
        echo -e "------------------------------------------------------------------"
        echo -e "${p}[${k}1${p}] Ekstrak hash file ZIP${r}"
        echo -e "${p}[${k}2${p}] Ekstrak hash file RAR${r}"
        echo -e "${p}[${k}3${p}] Ekstrak hash file 7z${r}"
        echo -e "${p}[${k}4${p}] Ekstrak hash file PDF${r}"
        echo -e "${p}[${k}5${p}] Ekstrak hash file Office (.docx, .xlsx, .pptx)${r}"
        echo -e "${p}------------------------------------------------------------------${r}"
        echo -e "${p}[${k}6${p}] Pulihkan kata sandi file ZIP${r}"
        echo -e "${p}[${k}7${p}] Pulihkan kata sandi file RAR${r}"
        echo -e "${p}[${k}8${p}] Pulihkan kata sandi file 7z${r}"
        echo -e "${p}[${k}9${p}] Pulihkan kata sandi file PDF${r}"
        echo -e "${p}[${k}10${p}] Pulihkan kata sandi file Office (.docx, .xlsx, .pptx)${r}"
        echo -e "${p}------------------------------------------------------------------${r}"
        echo -e "${p}[${k}11${p}] Tentang${r}"
        echo -e "${p}------------------------------------------------------------------${r}"
}

function pilih_menu(){
        while true; do
                read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Pilih menu: '  pilih_menu
                if [[  "${pilih_menu}" == "0" ]]; then
			keluar
		elif [[ "${pilih_menu}" == "1" ]]; then
			memasukkan_file_zip
			ekstrak_hash_file_zip
		elif [[ "${pilih_menu}" == "2" ]]; then
			memasukkan_file_rar
			ekstrak_hash_file_rar
		elif [[ "${pilih_menu}" == "3" ]]; then
			memasukkan_file_7z
			ekstrak_hash_file_7z
		elif [[ "${pilih_menu}" == "4" ]]; then
			memasukkan_file_pdf
			ekstrak_hash_file_pdf
		elif [[ "${pilih_menu}" == "5" ]]; then
			memasukkan_file_office
			ekstrak_hash_file_office
		elif [[ "${pilih_menu}" == "6" ]]; then
			memasukkan_file_hash_file_zip
			memasukkan_file_wordlist
			memulihkan_kata_sandi_file_zip
		elif [[ "${pilih_menu}" == "7" ]]; then
			memasukkan_file_hash_file_rar
			memasukkan_file_wordlist
			memulihkan_kata_sandi_file_rar
		elif [[ "${pilih_menu}" == "8" ]]; then
			memasukkan_file_hash_file_7z
			memasukkan_file_wordlist
			memulihkan_kata_sandi_file_7z
                elif [[ "${pilih_menu}" == "9" ]]; then
			memasukkan_file_hash_file_pdf
			memasukkan_file_wordlist
			memulihkan_kata_sandi_file_pdf
                elif [[ "${pilih_menu}" == "10" ]]; then
			memasukkan_file_hash_file_office
			memasukkan_file_wordlist
			memulihkan_kata_sandi_file_office
		else
			echo -e "${p}[${m}-${p}] Menu '${pilih_menu}' tidak tersedia. Silahkan pilih kembali.${r}"
			continue
		fi
	done
}


# Fungsi utama
function utama(){
	mengecek_root
	membuat_folder_file_hash
	menampilkan_kata_kata_peringatan
	mengecek_sistem_operasi
	mengecek_alat
	menampilkan_menu
	pilih_menu
}

utama
