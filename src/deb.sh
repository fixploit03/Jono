#!/bin/bash
#-------------------------------------------
# [jono_deb_ubuntu.sh]
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
	echo -e "${b}Selamat datang di Jono${r}"
	echo -e "${p}----------------------${r}"
	echo -e "${p}Jono adalah program Bash sederhana yang dirancang untuk memulihkan kata sandi${r}"
	echo -e "${p}file ZIP, RAR, 7Z, PDF, dan file Office (.docx, .xlsx, .pptx). Menggunakan${r}"
	echo -e "${p}John The Ripper.${r}"
	echo ""
	echo -e "${m}Peringatan${r}"
	echo -e "${p}----------${r}"
	echo -e "${p}Program ini dirancang hanya untuk tujuan pendidikan dan penelitian${r}"
	echo -e "${p}yang sah. Dilarang keras menggunakan program ini untuk kegiatan ilegal,${r}"
	echo -e "${p}merusak, atau tanpa izin pemilik file. Pengguna bertanggung jawab penuh${r}"
	echo -e "${p}atas segala konsekuensi hukum yang mungkin timbul dari penggunaan${r}"
	echo -e "${p}program ini. Pastikan untuk selalu mematuhi peraturan dan etika yang${r}"
	echo -e "${p}berlaku di wilayah Anda.${r}"
	echo ""
}

# Fungsi untuk konfirmasi
function konfirmasi(){
	while true; do
		read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Apakah Anda ingin melanjutkannya [Y/n]: ' konfirmasi
		if [[ "${konfirmasi}" == "y" || "${konfirmasi}" == "Y" ]]; then
			break
		elif [[ "${konfirmasi}" == "n" || "${konfirmasi}" == "N" ]]; then
			keluar
		else
			echo -e "${p}[${m}-${p}] Masukkan tidak valid. Harap masukkan 'y' atau 'n'.${r}"
			continue
		fi
	done
}

# Fugsi untuk tunggu selama 3 detik
function tunggu(){
	sleep 3
}

# Fungsi untuk mengecek sistem operasi
function mengecek_sistem_operasi(){
	echo ""
	echo -e "${p}[${b}*${p}] Mengecek sistem operasi...${r}"
	tunggu
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
	if [[ "${id_linux}" != "debian" && "${id_linux}" != "ubuntu" ]]; then
	        echo -e "${p}[${m}-${p}] Sistem operasi Anda tidak mendukung untuk menjalankan program Jono.${r}"
	        exit 1
	fi

	echo -e "${p}[${h}+${p}] Sistem operasi Anda: ${sistem_operasi} (${id_linux}).${r}"
}

# Fungsi untuk mengecek alat
function mengecek_alat(){

	folder_john="/usr/share/john/run"

	daftar_alat=(
	        "john"
	        "zip2john"
	        "rar2john"
	        "7z2john.pl"
        	"pdf2john.pl"
	        "office2john.py"
	)

	# Alat yang belum terinstal
	daftar_alat_belum_terinstal=()

	echo -e "${p}[${b}*${p}] Mengecek alat-alat yang dibutuhkan oleh program Jono...${r}"
	tunggu

	for alat in "${daftar_alat[@]}"; do

		path="${folder_john}/${alat}"
		alat=$(basename "${path}")
		if [[ "${alat}" == "7z2john.pl" ]]; then
			alat="7z2john"
		fi
		if [[ "${alat}" == "pdf2john.pl" ]]; then
			alat="pdf2john"
		fi
		if [[ "${alat}" == "office2john.py" ]]; then
			alat="office2john"
		fi

	        echo -e "${p}[${b}*${p}] Mengecek '${alat}'...${r}"
        	tunggu
        	if [[ ! -f "${path}" ]]; then
	                echo -e "${p}[${m}-${p}] '${alat}' belum terinstal.${r}"
        	        daftar_alat_belum_terinstal+=("${alat}")
	        else
        	        echo -e "${p}[${h}+${p}] '${alat}' sudah terinstal.${r}"
	        fi
	done

	if [[ "${#daftar_alat_belum_terinstal[@]}" -ne 0 ]]; then
        	echo -e "${p}[${m}-${p}] Program Jono tidak dapat dijalankan karena ada beberapa alat yang belum terinstal..${r}"
	        echo ""
	        echo -e "${p}Alat yang belum terinstal:${r}"
        	for alat_belum_terinstal in "${daftar_alat_belum_terinstal[@]}"; do
                	echo -e "${p}- ${alat_belum_terinstal}${r}"
	        done
	        echo ""
	        echo -e "${p}Silakan install dengan mengetikan perintah 'bash instal_john.sh'${r}"
                exit 1

	fi

	echo -e "${p}[${h}+${p}] Semua alat yang dibutuhkan oleh program Jono sudah terinstal.${r}"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk melanjutkan...\e[0m'
}

# Fungsi untuk keluar program
function keluar(){
	echo -e "${p}[${b}*${p}] Semoga harimu menyenangkan ^_^${r}" 
	exit 1
}

# Fungsi untuk menampilkan banner ekstrak hash file ZIP
function banner_ekstrak_hash_file_zip(){
	membersihkan_layar_terminal
	echo -e "${b}    ________  _____________${r}"
	echo -e "${b}   / ____/ / / / ____/__  /${r}"
	echo -e "${b}  / __/ / /_/ / /_     / / ${r}"
	echo -e "${b} / /___/ __  / __/    / /__${p} Ekstrak hash file ZIP${r}"
	echo -e "${b}/_____/_/ /_/_/      /____/${h} https://github.com/fixploit03/Jono/${r}"
	echo ""
}

# Fungsi untuk menampilkan banner ekstrak hash file RAR
function banner_ekstrak_hash_file_rar(){
	membersihkan_layar_terminal
	echo -e "${b}    ________  ____________  ${r}"
	echo -e "${b}   / ____/ / / / ____/ __ \ ${r}"
	echo -e "${b}  / __/ / /_/ / /_  / /_/ / ${r}"
	echo -e "${b} / /___/ __  / __/ / _, _/${p} Ekstrak hash file RAR${r} "
	echo -e "${b}/_____/_/ /_/_/   /_/ |_| ${h} https://github.com/fixploit03/Jono/${r} "
	echo ""
}

# Fungsi untuk menampilkan banner ekstrak hash file 7z
function banner_ekstrak_hash_file_7z(){
	membersihkan_layar_terminal
	echo -e "${b}    ________  _____________${r}"
	echo -e "${b}   / ____/ / / / ____/__  /${r}"
	echo -e "${b}  / __/ / /_/ / /_     / /${r}"
	echo -e "${b} / /___/ __  / __/    / / ${p}Ekstrak hash file 7z${r}"
	echo -e "${b}/_____/_/ /_/_/      /_/  ${h}https://github.com/fixploit03/Jono/${r}"
	echo ""
}

# Fungsi untuk menampilkan banner ekstrak hash file PDF
function banner_ekstrak_hash_file_pdf(){
	membersihkan_layar_terminal
	echo -e "${b}    ________  ____________  ${r}"
	echo -e "${b}   / ____/ / / / ____/ __ \ ${r}"
	echo -e "${b}  / __/ / /_/ / /_  / /_/ / ${r}"
	echo -e "${b} / /___/ __  / __/ / ____/ ${p}Ekstrak hash file PDF${r}"
	echo -e "${b}/_____/_/ /_/_/   /_/      ${h}https://github.com/fixploit03/Jono/${r}"
	echo ""
}

# Fungsi untuk menampilkan banner ekstrak hash file Office
function banner_ekstrak_hash_file_office(){
	membersihkan_layar_terminal
	echo -e "${b}    ________  ____________  ${r}"
	echo -e "${b}   / ____/ / / / ____/ __ \ ${r}"
	echo -e "${b}  / __/ / /_/ / /_  / / / / ${r}"
	echo -e "${b} / /___/ __  / __/ / /_/ / ${p}Ekstrak hash file Ofiice (.docx, .xlsx, .pptx)${r}"
	echo -e "${b}/_____/_/ /_/_/    \____/  ${h}https://github.com/fixploit03/Jono/${r}"
        echo ""

}

# Fungsi untuk menampilkan banner pulihkan kata sandi file ZIP
function banner_pulihkan_kata_sandi_file_zip(){
	membersihkan_layar_terminal
	echo -e "${b}    ____  __ _______ ___________ ${r}"
	echo -e "${b}   / __ \/ //_/ ___// ____/__  / ${r}"
	echo -e "${b}  / /_/ / ,<  \__ \/ /_     / /  ${r}"
	echo -e "${b} / ____/ /| |___/ / __/    / /__ ${p}Pulihkan kata sandi file ZIP${r}"
	echo -e "${b}/_/   /_/ |_/____/_/      /____/ ${h}https://github.com/fixploit03/Jono/${r}"
	echo ""
}

# Fungsi untuk menampilkan banner pulihkan kata sandi file RAR
function banner_pulihkan_kata_sandi_file_rar(){
	membersihkan_layar_terminal
	echo -e "${b}    ____  __ _______ __________  ${r}"
	echo -e "${b}   / __ \/ //_/ ___// ____/ __ \ ${r}"
	echo -e "${b}  / /_/ / ,<  \__ \/ /_  / /_/ / ${r}"
	echo -e "${b} / ____/ /| |___/ / __/ / _, _/ ${p}Pulihkan kata sandi file RAR${r}"
	echo -e "${b}/_/   /_/ |_/____/_/   /_/ |_|  ${h}https://github.com/fixploit03/Jono/${r}"
	echo ""
}

# Fungsi untuk menampilkan banner pulihkan kata sandi file 7z
function banner_pulihkan_kata_sandi_file_7z(){
	membersihkan_layar_terminal
	echo -e "${b}    ____  __ _______ ___________${r}"
	echo -e "${b}   / __ \/ //_/ ___// ____/__  /${r}"
	echo -e "${b}  / /_/ / ,<  \__ \/ /_     / / ${r}"
	echo -e "${b} / ____/ /| |___/ / __/    / / ${p}Pulihkan kata sandi file 7z${r}"
	echo -e "${b}/_/   /_/ |_/____/_/      /_/  ${h}https://github.com/fixploit03/Jono/${r}"
        echo ""

}

# Fungsi untuk menampilkan banner pulihkan kata sandi file PDF
function banner_pulihkan_kata_sandi_file_pdf(){
	membersihkan_layar_terminal
	echo -e "${b}    ____  __ _______ __________  ${r}"
	echo -e "${b}   / __ \/ //_/ ___// ____/ __ \ ${r}"
	echo -e "${b}  / /_/ / ,<  \__ \/ /_  / /_/ / ${r}"
	echo -e "${b} / ____/ /| |___/ / __/ / ____/ ${p}Pulihkan kata sandi file PDF${r}"
	echo -e "${b}/_/   /_/ |_/____/_/   /_/      ${h}https://github.com/fixploit03/Jono/${r}"
	echo ""
}

# Fungsi untuk menampilkan banner pulihkan kata sandi file Office
function banner_pulihkan_kata_sandi_file_office(){
	membersihkan_layar_terminal
	echo -e "${b}    ____  __ _______ __________  ${r}"
	echo -e "${b}   / __ \/ //_/ ___// ____/ __ \ ${r}"
	echo -e "${b}  / /_/ / ,<  \__ \/ /_  / / / / ${r}"
	echo -e "${b} / ____/ /| |___/ / __/ / /_/ / ${p}Pulihkan kata sandi file Office (.docx, .xlsx, .pptx)${r}"
	echo -e "${b}/_/   /_/ |_/____/_/    \____/  ${h}https://github.com/fixploit03/Jono/${r}"
	echo ""
}

# Fungsi untuk menampilkan banner tentang program Jono
function banner_tentang_program_jono(){
	membersihkan_layar_terminal
	echo -e "${b}  __________      __${r}"
	echo -e "${b} /_  __/ __ \    / /${r}"
	echo -e "${b}  / / / /_/ /_  / / ${r}"
	echo -e "${b} / / / ____/ /_/ / ${p}Tentang program Jono${r}"
	echo -e "${b}/_/ /_/    \____/  ${h}https://github.com/fixploit03/Jono/${r}"
	echo ""
}

# Fungsi untuk memasukkan file ZIP
function memasukkan_file_zip(){
	while true; do
        	read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan nama file ZIP: ' file_zip
		file_zip=$(echo "${file_zip}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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
		file_rar=$(echo "${file_rar}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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
		file_7z=$(echo "${file_7z}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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
		file_pdf=$(echo "${file_pdf}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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
		file_office=$(echo "${file_office}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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
        hash_file_zip=$(/usr/share/john/run/zip2john "${file_zip}" 2>/dev/null)
        nama_file_zip=$(basename "${file_zip}")
        nama_file_hash_file_zip="${lokasi_file_hash}/${nama_file_zip}.john"
        echo "${hash_file_zip}" >> "${nama_file_hash_file_zip}"
        if [[ -f "${nama_file_hash_file_zip}" ]]; then
                if [[ $(cat "${nama_file_hash_file_zip}" | grep -o "zip" || cat "${nama_file_hash_file_zip}" | grep -o "pkzip") ]]; then
                        echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file ZIP '${file_zip}'.${r}"
                        echo -e "${p}[${h}+${p}] File hash file ZIP '${file_zip}' disimpan di: ${h}${nama_file_hash_file_zip}${p}${r}"
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
        hash_file_rar=$(/usr/share/john/run/rar2john "${file_rar}" 2>/dev/null)
        nama_file_rar=$(basename "${file_rar}")
        nama_file_hash_file_rar="${lokasi_file_hash}/${nama_file_rar}.john"
        echo "${hash_file_rar}" >> "${nama_file_hash_file_rar}"
        if [[ -f "${nama_file_hash_file_rar}" ]]; then
        	if [[ $(cat "${nama_file_hash_file_rar}" | grep -o "rar5") ]]; then
                     	echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file RAR '${file_rar}'.${r}"
                        echo -e "${p}[${h}+${p}] File hash file RAR '${file_rar}' disimpan di: ${h}${nama_file_hash_file_rar}${p}${r}"
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
        hash_file_7z=$(/usr/share/john/run/7z2john.pl "${file_7z}" 2>/dev/null)
        nama_file_7z=$(basename "${file_7z}")
        nama_file_hash_file_7z="${lokasi_file_hash}/${nama_file_7z}.john"
        echo "${hash_file_7z}" >> "${nama_file_hash_file_7z}"
        if [[ -f "${nama_file_hash_file_7z}" ]]; then
                if [[ $(cat "${nama_file_hash_file_7z}" | grep -o "7z") ]]; then
                	echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file 7z '${file_7z}'.${r}"
                        echo -e "${p}[${h}+${p}] File hash file 7z '${file_7z}' disimpan di: ${h}${nama_file_hash_file_7z}${p}${r}"
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
        hash_file_pdf=$(/usr/share/john/run/pdf2john.pl "${file_pdf}")
        nama_file_pdf=$(basename "${file_pdf}")
        nama_file_hash_file_pdf="${lokasi_file_hash}/${nama_file_pdf}.john"
        echo "${hash_file_pdf}" >> "${nama_file_hash_file_pdf}"
        if [[ -f "${nama_file_hash_file_pdf}" ]]; then
        	if [[ $(cat "${nama_file_hash_file_pdf}" | grep -o "pdf") ]]; then
                	echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file PDF '${file_pdf}'.${r}"
                        echo -e "${p}[${h}+${p}] File hash file PDF '${file_pdf}' disimpan di: ${h}${nama_file_hash_file_pdf}${p}${r}"
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
        hash_file_office=$(/usr/share/john/run/office2john.py "${file_office}")
        nama_file_office=$(basename "${file_office}")
        nama_file_hash_file_office="${lokasi_file_hash}/${nama_file_office}.john"
        echo "${hash_file_office}" >> "${nama_file_hash_file_office}"
        if [[ -f "${nama_file_hash_file_office}" ]]; then
        	if [[ $(cat "${nama_file_hash_file_office}" | grep -o "office") ]]; then
                	echo -e "${p}[${h}+${p}] Berhasil mengekstrak hash file Office '${file_office}'.${r}"
                        echo -e "${p}[${h}+${p}] File hash file Office '${file_office}' disimpan di: ${h}${nama_file_hash_file_office}${p}${r}"
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
		file_hash_file_zip=$(echo "${file_hash_file_zip}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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
		file_hash_file_rar=$(echo "${file_hash_file_rar}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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
		file_hash_file_7z=$(echo "${file_hash_file_7z}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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
		file_hash_file_pdf=$(echo "${file_hash_file_pdf}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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
		file_hash_file_office=$(echo "${file_hash_file_office}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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
		file_wordlist=$(echo "${file_wordlist}" | sed -e "s/^[ \t]*//" -e "s/[ \t]*$//" -e "s/^['\"]//" -e "s/['\"]$//")
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

# Fungsi untuk menentukan panjang kata sandi
function menentukan_panjang_kata_sandi(){

	# Memasukkan panjang minimal kata sandi
	while true; do
		read -p $'\e[1;37m[\e[;34m#\e[1;37m] Masukkan panjang minimal kata sandi: ' min
		if [[ -z "${min}" ]]; then
			echo -e "${p}[${m}-${p}] Panjang minimal kata sandi tidak boleh kosong.${r}"
			continue
		fi
                if [[ "${min}" =~ ^0 ]]; then
		        echo -e "${p}[${m}-${p}] Panjang minimal kata sandi tidak boleh diawali dengan angka nol.${r}"
                        continue
                fi
		if [[ ! "${min}" =~ ^[0-9]+$ ]]; then
			echo -e "${p}[${m}-${p}] Masukkan tidak valid. Harap masukkan angka.${r}"
			continue
		fi
		break
	done

	# Memasukkan panjang maksimal kata sandi
	while true; do
		read -p $'\e[1;37m[\e[;34m#\e[1;37m] Masukkan panjang maksimal kata sandi: ' maks
		if [[ -z "${maks}" ]]; then
			echo -e "${p}[${m}-${p}] Jumlah maksimal kata sandi tidak boleh kosong.${r}"
			continue
		fi
		if [[ ! "${maks}" =~ ^[0-9]+$ ]]; then
			echo -e "${p}[${m}-${p}] Masukkan tidak valid. Harap masukkan angka.${r}"
			continue
		fi
		if [[ ! "${maks}" -ge "${min}" ]]; then
			echo -e "${p}[${m}-${p}] Panjang maksimal kata sandi harus lebih besar atau sama dengan panjang minimal kata sandi.${r}"
			continue
		fi
		break
	done

}

# Fungi untuk menentukan pola mask
function menentukan_pola_mask(){

	while true; do
		read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan pola mask (?l?u?d?s?a): ' pola_mask

		if [[ -z "${pola_mask}" ]]; then
			echo -e "${p}[${m}-${p}] Pola mask tidak boleh kosong.${r}"
			continue
		fi
		if [[ ! "${pola_mask}" =~ ^(\?l|\?u|\?d|\?s|\?a)+$ ]]; then
			echo -e "${p}[${m}-${p}] Pola mask tidak valid. Harap masukkan pola mask '?l untuk huruf kecil', '?u untuk huruf besar', '?d untuk angka', '?s untuk simbol' dan '?a untuk menggunakan semua kombinasi karakter'.${r}"
			continue
		fi
		break
	done
}

# Fungsi untuk menentukan kombinasi karakter
function menentukan_kombinasi_karakter(){
	while true; do
		read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Masukkan kombinasi karakter (aA1$): ' kombinasi
		if [[ -z "${kombinasi}" ]]; then
			echo -e "${p}L[${m}-${p}] Kombinasi karakter tidak boleh kosong.${r}"
			continue
		fi
		break
	done
}

# Fungsi untuk memulihkan kata sandi file ZIP menggunakan teknik Dictionary Attack
function memulihkan_kata_sandi_file_zip_dict(){
	memasukkan_file_wordlist
	pot_file_zip="pot_zip.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file ZIP...\e[0m'
	echo ""
	if [[ $(cat "${file_hash_file_zip}" | grep -o "pkzip") ]]; then
		format_file_zip="PKZIP"
	elif [[ $(cat "${file_hash_file_zip}" | grep -o "zip") ]]; then
		format_file_zip="ZIP"
	fi
	/usr/share/john/run/john --wordlist="${file_wordlist}" --format="${format_file_zip}" --pot="${pot_file_zip}" --verbosity=6 --progress-every=1 "${file_hash_file_zip}"
	if [[ -f "${pot_file_zip}" ]]; then
		if [[ $(cat "${pot_file_zip}" | grep -o ":") ]]; then
			kata_sandi_file_zip=$(cat "${pot_file_zip}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file ZIP berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_zip}${p}${r}"
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

# Fungsi untuk memulihkan kata sandi file RAR menggunakan teknik Dictionary Attack
function memulihkan_kata_sandi_file_rar_dict(){
	memasukkan_file_wordlist
	pot_file_rar="pot_rar.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file RAR...\e[0m'
	echo ""
	format_file_rar="RAR5"
	/usr/share/john/run/john --wordlist="${file_wordlist}" --format="${format_file_rar}" --pot="${pot_file_rar}" --verbosity=6 --progress-every=1 "${file_hash_file_rar}"
	if [[ -f "${pot_file_rar}" ]]; then
		if [[ $(cat "${pot_file_rar}" | grep -o ":") ]]; then
			kata_sandi_file_rar=$(cat "${pot_file_rar}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file RAR berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_rar}${p}${r}"
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

# Fungsi untuk memulihkan kata sandi file 7z menggunakan teknik Dictionary Attack
function memulihkan_kata_sandi_file_7z_dict(){
	memasukkan_file_wordlist
	pot_file_7z="pot_7z.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file 7z...\e[0m'
	echo ""
	format_file_7z="7z"
	/usr/share/john/run/john --wordlist="${file_wordlist}" --format="${format_file_7z}" --pot="${pot_file_7z}" --verbosity=6 --progress-every=1 "${file_hash_file_7z}"
	if [[ -f "${pot_file_7z}" ]]; then
		if [[ $(cat "${pot_file_7z}" | grep -o ":") ]]; then
			kata_sandi_file_7z=$(cat "${pot_file_7z}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file 7z berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_7z}${p}${r}"
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

# Fungsi untuk memulihkan kata sandi file PDF menggunakan teknik Dictionary Attack
function memulihkan_kata_sandi_file_pdf_dict(){
	memasukkan_file_wordlist
	pot_file_pdf="pot_pdf.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file PDF...\e[0m'
	echo ""
	format_file_pdf="PDF"
	/usr/share/john/run/john --wordlist="${file_wordlist}" --format="${format_file_pdf}" --pot="${pot_file_pdf}" --verbosity=6 --progress-every=1 "${file_hash_file_pdf}"
	if [[ -f "${pot_file_pdf}" ]]; then
		if [[ $(cat "${pot_file_pdf}" | grep -o ":") ]]; then
			kata_sandi_file_pdf=$(cat "${pot_file_pdf}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file PDF berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_pdf}${p}${r}"
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

# Fungsi untuk memulihkan kata sandi file Office menggunakan teknik Dictionary Attack
function memulihkan_kata_sandi_file_office_dict(){
	memasukkan_file_wordlist
	pot_file_office="pot_office.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file Office...\e[0m'
	echo ""
	format_file_office="Office"
	/usr/share/john/run/john --wordlist="${file_wordlist}" --format="${format_file_office}" --pot="${pot_file_office}" --verbosity=6 --progress-every=1 "${file_hash_file_office}"
	if [[ -f "${pot_file_office}" ]]; then
		if [[ $(cat "${pot_file_office}" | grep -o ":") ]]; then
			kata_sandi_file_office=$(cat "${pot_file_office}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file Office berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_office}${p}${r}"
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

# Fungsi untuk memulihkan kata sandi file ZIP menggunakan teknik Brute Force Attack
function memulihkan_kata_sandi_file_zip_brute(){
	menentukan_panjang_kata_sandi
	pot_file_zip="pot_zip.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file ZIP...\e[0m'
	echo ""
	if [[ $(cat "${file_hash_file_zip}" | grep -o "pkzip") ]]; then
		format_file_zip="PKZIP"
	elif [[ $(cat "${file_hash_file_zip}" | grep -o "zip") ]]; then
		format_file_zip="ZIP"
	fi
	/usr/share/john/run/john --incremental --min-length="${min}" --max-length="${maks}" --format="${format_file_zip}" --pot="${pot_file_zip}" --verbosity=6 --progress-every=1 "${file_hash_file_zip}"
	if [[ -f "${pot_file_zip}" ]]; then
		if [[ $(cat "${pot_file_zip}" | grep -o ":") ]]; then
			kata_sandi_file_zip=$(cat "${pot_file_zip}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file ZIP berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_zip}${p}${r}"
			rm "${pot_file_zip}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file ZIP gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan kombinasi panjang minimal dan maksimal kata sandi yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file RAR menggunakan teknik Brute Force Attack
function memulihkan_kata_sandi_file_rar_brute(){
	menentukan_panjang_kata_sandi
	pot_file_rar="pot_rar.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file RAR...\e[0m'
	echo ""
	format_file_rar="RAR5"
	/usr/share/john/run/john --incremental --min-length="${min}" --max-length="${maks}" --format="${format_file_rar}" --pot="${pot_file_rar}" --verbosity=6 --progress-every=1 "${file_hash_file_rar}"
	if [[ -f "${pot_file_rar}" ]]; then
		if [[ $(cat "${pot_file_rar}" | grep -o ":") ]]; then
			kata_sandi_file_rar=$(cat "${pot_file_rar}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file RAR berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_rar}${p}${r}"
			rm "${pot_file_rar}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file RAR gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan kombinasi panjang minimal dan maksimal kata sandi yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file 7z menggunakan teknik Brute Force Attack
function memulihkan_kata_sandi_file_7z_brute(){
	menentukan_panjang_kata_sandi
	pot_file_7z="pot_7z.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file 7z...\e[0m'
	echo ""
	format_file_7z="7z"
	/usr/share/john/run/john --incremental --min-length="${min}" --max-length="${maks}" --format="${format_file_7z}" --pot="${pot_file_7z}" --verbosity=6 --progress-every=1 "${file_hash_file_7z}"
	if [[ -f "${pot_file_7z}" ]]; then
		if [[ $(cat "${pot_file_7z}" | grep -o ":") ]]; then
			kata_sandi_file_7z=$(cat "${pot_file_7z}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file 7z berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_7z}${p}${r}"
			rm "${pot_file_7z}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file 7z gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan kombinasi panjang minimal dan maksimal kata sandi yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file PDF menggunakan teknik Brute Force Attack
function memulihkan_kata_sandi_file_pdf_brute(){
	menentukan_panjang_kata_sandi
	pot_file_pdf="pot_pdf.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file PDF...\e[0m'
	echo ""
	format_file_pdf="PDF"
	/usr/share/john/run/john --incremental --min-length="${min}" --max-length="${maks}" --format="${format_file_pdf}" --pot="${pot_file_pdf}" --verbosity=6 --progress-every=1 "${file_hash_file_pdf}"
	if [[ -f "${pot_file_pdf}" ]]; then
		if [[ $(cat "${pot_file_pdf}" | grep -o ":") ]]; then
			kata_sandi_file_pdf=$(cat "${pot_file_pdf}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file PDF berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_pdf}${p}${r}"
			rm "${pot_file_pdf}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file PDF gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan kombinasi panjang minimal dan maksimal kata sandi yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file Office menggunakan teknik Brute Force Attack
function memulihkan_kata_sandi_file_office_brute(){
	menentukan_panjang_kata_sandi
	pot_file_office="pot_office.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file Office...\e[0m'
	echo ""
	format_file_office="Office"
	/usr/share/john/run/john --incremental --min-length="${min}" --max-length="${maks}" --format="${format_file_office}" --pot="${pot_file_office}" --verbosity=6 --progress-every=1 "${file_hash_file_office}"
	if [[ -f "${pot_file_office}" ]]; then
		if [[ $(cat "${pot_file_office}" | grep -o ":") ]]; then
			kata_sandi_file_office=$(cat "${pot_file_office}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file Office berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_office}${p}${r}"
			rm "${pot_file_office}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file Office gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan kombinasi panjang minimal dan maksimal kata sandi yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file ZIP menggunakan teknik Mask Attack
function memulihkan_kata_sandi_file_zip_mask(){
	menentukan_panjang_kata_sandi
	menentukan_pola_mask
	pot_file_zip="pot_zip.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file ZIP...\e[0m'
	echo ""
	if [[ $(cat "${file_hash_file_zip}" | grep -o "pkzip") ]]; then
		format_file_zip="PKZIP"
	elif [[ $(cat "${file_hash_file_zip}" | grep -o "zip") ]]; then
		format_file_zip="ZIP"
	fi
	/usr/share/john/run/john --mask="${pola_mask}" --min-length="${min}" --max-length="${maks}" --format="${format_file_zip}" --pot="${pot_file_zip}" --verbosity=6 --progress-every=1 "${file_hash_file_zip}"
	if [[ -f "${pot_file_zip}" ]]; then
		if [[ $(cat "${pot_file_zip}" | grep -o ":") ]]; then
			kata_sandi_file_zip=$(cat "${pot_file_zip}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file ZIP berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_zip}${p}${r}"
			rm "${pot_file_zip}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file ZIP gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan panjang minimal, maksimal kata sandi dan pola mask yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file RAR menggunakan teknik Mask Attack
function memulihkan_kata_sandi_file_rar_mask(){
	menentukan_panjang_kata_sandi
	menentukan_pola_mask
	pot_file_rar="pot_rar.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file RAR...\e[0m'
	echo ""
	format_file_rar="RAR5"
	/usr/share/john/run/john --mask="${pola_mask}" --min-length="${min}" --max-length="${maks}" --format="${format_file_rar}" --pot="${pot_file_rar}" --verbosity=6 --progress-every=1 "${file_hash_file_rar}"
	if [[ -f "${pot_file_rar}" ]]; then
		if [[ $(cat "${pot_file_rar}" | grep -o ":") ]]; then
			kata_sandi_file_rar=$(cat "${pot_file_rar}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file RAR berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_rar}${p}${r}"
			rm "${pot_file_rar}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file RAR gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan panjang minimal, maksimal kata sandi dan pola mask yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file 7z menggunakan teknik Mask Attack
function memulihkan_kata_sandi_file_7z_mask(){
	menentukan_panjang_kata_sandi
	menentukan_pola_mask
	pot_file_7z="pot_7z.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file 7z...\e[0m'
	echo ""
	format_file_7z="7z"
	/usr/share/john/run/john --mask="${pola_mask}" --min-length="${min}" --max-length="${maks}" --format="${format_file_7z}" --pot="${pot_file_7z}" --verbosity=6 --progress-every=1 "${file_hash_file_7z}"
	if [[ -f "${pot_file_7z}" ]]; then
		if [[ $(cat "${pot_file_7z}" | grep -o ":") ]]; then
			kata_sandi_file_7z=$(cat "${pot_file_7z}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file 7z berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_7z}${p}${r}"
			rm "${pot_file_7z}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file 7z gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan panjang minimal, maksimal kata sandi dan pola mask yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file PDF menggunakan teknik Mask Attack
function memulihkan_kata_sandi_file_pdf_mask(){
	menentukan_panjang_kata_sandi
	menentukan_pola_mask
	pot_file_pdf="pot_pdf.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file PDF...\e[0m'
	echo ""
	format_file_pdf="PDF"
	/usr/share/john/run/john --mask="${pola_mask}" --min-length="${min}" --max-length="${maks}" --format="${format_file_pdf}" --pot="${pot_file_pdf}" --verbosity=6 --progress-every=1 "${file_hash_file_pdf}"
	if [[ -f "${pot_file_pdf}" ]]; then
		if [[ $(cat "${pot_file_pdf}" | grep -o ":") ]]; then
			kata_sandi_file_pdf=$(cat "${pot_file_pdf}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file PDF berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_pdf}${p}${r}"
			rm "${pot_file_pdf}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file PDF gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan panjang minimal, maksimal kata sandi dan pola mask yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file Office menggunakan teknik Mask Attack
function memulihkan_kata_sandi_file_office_mask(){
	menentukan_panjang_kata_sandi
	menentukan_pola_mask
	pot_file_office="pot_office.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file Office...\e[0m'
	echo ""
	format_file_office="Office"
	/usr/share/john/run/john --mask="${pola_mask}" --min-length="${min}" --max-length="${maks}" --format="${format_file_office}" --pot="${pot_file_office}" --verbosity=6 --progress-every=1 "${file_hash_file_office}"
	if [[ -f "${pot_file_office}" ]]; then
		if [[ $(cat "${pot_file_office}" | grep -o ":") ]]; then
			kata_sandi_file_office=$(cat "${pot_file_office}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file Office berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_office}${p}${r}"
			rm "${pot_file_office}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file Office gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan panjang minimal, maksimal kata sandi dan pola mask yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file ZIP menggunakan teknik Prince Attack
function memulihkan_kata_sandi_file_zip_prince(){
	memasukkan_file_wordlist
	pot_file_zip="pot_zip.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file ZIP...\e[0m'
	echo ""
	if [[ $(cat "${file_hash_file_zip}" | grep -o "pkzip") ]]; then
		format_file_zip="PKZIP"
	elif [[ $(cat "${file_hash_file_zip}" | grep -o "zip") ]]; then
		format_file_zip="ZIP"
	fi
	/usr/share/john/run/john --prince="${file_wordlist}" --format="${format_file_zip}" --pot="${pot_file_zip}" --verbosity=6 --progress-every=1 "${file_hash_file_zip}"
	if [[ -f "${pot_file_zip}" ]]; then
		if [[ $(cat "${pot_file_zip}" | grep -o ":") ]]; then
			kata_sandi_file_zip=$(cat "${pot_file_zip}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file ZIP berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_zip}${p}${r}"
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

# Fungsi untuk memulihkan kata sandi file RAR menggunakan teknik Prince Attack
function memulihkan_kata_sandi_file_rar_prince(){
	memasukkan_file_wordlist
	pot_file_rar="pot_rar.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file RAR...\e[0m'
	echo ""
	format_file_rar="RAR5"
	/usr/share/john/run/john --prince="${file_wordlist}" --format="${format_file_rar}" --pot="${pot_file_rar}" --verbosity=6 --progress-every=1 "${file_hash_file_rar}"
	if [[ -f "${pot_file_rar}" ]]; then
		if [[ $(cat "${pot_file_rar}" | grep -o ":") ]]; then
			kata_sandi_file_rar=$(cat "${pot_file_rar}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file RAR berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_rar}${p}${r}"
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

# Fungsi untuk memulihkan kata sandi file 7z menggunakan teknik Prince Attack
function memulihkan_kata_sandi_file_7z_prince(){
	memasukkan_file_wordlist
	pot_file_7z="pot_7z.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file 7z...\e[0m'
	echo ""
	format_file_7z="7z"
	/usr/share/john/run/john --prince="${file_wordlist}" --format="${format_file_7z}" --pot="${pot_file_7z}" --verbosity=6 --progress-every=1 "${file_hash_file_7z}"
	if [[ -f "${pot_file_7z}" ]]; then
		if [[ $(cat "${pot_file_7z}" | grep -o ":") ]]; then
			kata_sandi_file_7z=$(cat "${pot_file_7z}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file 7z berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_7z}${p}${r}"
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

# Fungsi untuk memulihkan kata sandi file PDF menggunakan teknik Prince Attack
function memulihkan_kata_sandi_file_pdf_prince(){
	memasukkan_file_wordlist
	pot_file_pdf="pot_pdf.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file PDF...\e[0m'
	echo ""
	format_file_pdf="PDF"
	/usr/share/john/run/john --prince="${file_wordlist}" --format="${format_file_pdf}" --pot="${pot_file_pdf}" --verbosity=6 --progress-every=1 "${file_hash_file_pdf}"
	if [[ -f "${pot_file_pdf}" ]]; then
		if [[ $(cat "${pot_file_pdf}" | grep -o ":") ]]; then
			kata_sandi_file_pdf=$(cat "${pot_file_pdf}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file PDF berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_pdf}${p}${r}"
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

# Fungsi untuk memulihkan kata sandi file Office menggunakan teknik Prince Attack
function memulihkan_kata_sandi_file_office_prince(){
	memasukkan_file_wordlist
	pot_file_office="pot_office.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file Office...\e[0m'
	echo ""
	format_file_office="Office"
	/usr/share/john/run/john --prince="${file_wordlist}" --format="${format_file_office}" --pot="${pot_file_office}" --verbosity=6 --progress-every=1 "${file_hash_file_office}"
	if [[ -f "${pot_file_office}" ]]; then
		if [[ $(cat "${pot_file_office}" | grep -o ":") ]]; then
			kata_sandi_file_office=$(cat "${pot_file_office}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file Office berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_office}${p}${r}"
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

# Fungsi untuk memulihkan kata sandi file ZIP menggunakan Subsets Attack
function memulihkan_kata_sandi_file_zip_subsets(){
	menentukan_panjang_kata_sandi
	menentukan_kombinasi_karakter
	pot_file_zip="pot_zip.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file ZIP...\e[0m'
	echo ""
	if [[ $(cat "${file_hash_file_zip}" | grep -o "pkzip") ]]; then
		format_file_zip="PKZIP"
	elif [[ $(cat "${file_hash_file_zip}" | grep -o "zip") ]]; then
		format_file_zip="ZIP"
	fi
	/usr/share/john/run/john --subsets="${kombinasi}" --min-length="${min}" --max-length="${maks}" --format="${format_file_zip}" --pot="${pot_file_zip}" --verbosity=6 --progress-every=1 "${file_hash_file_zip}"
	if [[ -f "${pot_file_zip}" ]]; then
		if [[ $(cat "${pot_file_zip}" | grep -o ":") ]]; then
			kata_sandi_file_zip=$(cat "${pot_file_zip}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file ZIP berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_zip}${p}${r}"
			rm "${pot_file_zip}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file ZIP gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan panjang minimal, maksimal kata sandi dan kombinasi karakter yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file RAR menggunakan teknik Subsets Attack
function memulihkan_kata_sandi_file_rar_subsets(){
	menentukan_panjang_kata_sandi
	menentukan_kombinasi_karakter
	pot_file_rar="pot_rar.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file RAR...\e[0m'
	echo ""
	format_file_rar="RAR5"
	/usr/share/john/run/john --subsets="${kombinasi}" --min-length="${min}" --max-length="${maks}" --format="${format_file_rar}" --pot="${pot_file_rar}" --verbosity=6 --progress-every=1 "${file_hash_file_rar}"
	if [[ -f "${pot_file_rar}" ]]; then
		if [[ $(cat "${pot_file_rar}" | grep -o ":") ]]; then
			kata_sandi_file_rar=$(cat "${pot_file_rar}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file RAR berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_rar}${p}${r}"
			rm "${pot_file_rar}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file RAR gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan panjang minimal, maksimal kata sandi dan kombinasi karakter yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file 7z menggunakan teknik Subsets Attack
function memulihkan_kata_sandi_file_7z_subsets(){
	menentukan_panjang_kata_sandi
	menentukan_kombinasi_karakter
	pot_file_7z="pot_7z.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file 7z...\e[0m'
	echo ""
	format_file_7z="7z"
	/usr/share/john/run/john --subsets="${kombinasi}" --min-length="${min}" --max-length="${maks}" --format="${format_file_7z}" --pot="${pot_file_7z}" --verbosity=6 --progress-every=1 "${file_hash_file_7z}"
	if [[ -f "${pot_file_7z}" ]]; then
		if [[ $(cat "${pot_file_7z}" | grep -o ":") ]]; then
			kata_sandi_file_7z=$(cat "${pot_file_7z}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file 7z berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_7z}${p}${r}"
			rm "${pot_file_7z}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file 7z gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan panjang minimal, maksimal kata sandi dan kombinasi karakter yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file PDF menggunakan teknik Subsets Attack
function memulihkan_kata_sandi_file_pdf_subsets(){
	menentukan_panjang_kata_sandi
	menentukan_kombinasi_karakter
	pot_file_pdf="pot_pdf.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file PDF...\e[0m'
	echo ""
	format_file_pdf="PDF"
	/usr/share/john/run/john --subsets="${kombinasi}" --min-length="${min}" --max-length="${maks}" --format="${format_file_pdf}" --pot="${pot_file_pdf}" --verbosity=6 --progress-every=1 "${file_hash_file_pdf}"
	if [[ -f "${pot_file_pdf}" ]]; then
		if [[ $(cat "${pot_file_pdf}" | grep -o ":") ]]; then
			kata_sandi_file_pdf=$(cat "${pot_file_pdf}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file PDF berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_pdf}${p}${r}"
			rm "${pot_file_pdf}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file PDF gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan panjang minimal, maksimal kata sandi dan kombinasi karakter yang lain.${r}"
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

# Fungsi untuk memulihkan kata sandi file Office menggunakan teknik Subsets Attack
function memulihkan_kata_sandi_file_office_subsets(){
	menentukan_panjang_kata_sandi
	menentukan_kombinasi_karakter
	pot_file_office="pot_office.txt"
	echo ""
	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai proses pemulihan kata sandi file Office...\e[0m'
	echo ""
	format_file_office="Office"
	/usr/share/john/run/john --subsets="${kombinasi}" --min-length="${min}" --max-length="${maks}" --format="${format_file_office}" --pot="${pot_file_office}" --verbosity=6 --progress-every=1 "${file_hash_file_office}"
	if [[ -f "${pot_file_office}" ]]; then
		if [[ $(cat "${pot_file_office}" | grep -o ":") ]]; then
			kata_sandi_file_office=$(cat "${pot_file_office}" | cut -d ":" -f 2)
                        echo ""
			echo -e "${p}[${h}+${p}] Kata sandi file Office berhasil dipulihkan.${r}"
			echo -e "${p}[${h}+${p}] Kata sandi: ${h}${kata_sandi_file_office}${p}${r}"
			rm "${pot_file_office}"
		else
                        echo ""
			echo -e "${p}[${m}-${p}] Kata sandi file Office gagal dipulihkan.${r}"
			echo -e "${p}[${m}-${p}] Cobalah menggunakan panjang minimal, maksimal kata sandi dan kombinasi karakter yang lain.${r}"
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

# Fungsi untuk memilih teknik pemulihan kata sandi file ZIP
function memilih_teknik_pemulihan_kata_sandi_file_zip(){

	echo ""
	echo -e "${p}Teknik pemulihan kata sandi file ZIP yang tersedia:${r}"
	echo ""
	echo -e "${p}[${k}01${p}] Brute Force Attack${r}"
	echo -e "${p}[${k}02${p}] Dictionary Attack${r}"
	echo -e "${p}[${k}03${p}] Mask Attack${r}"
	echo -e "${p}[${k}04${p}] Prince Attack${r}"
	echo -e "${p}[${k}05${p}] Subsets Attack${r}"
	echo ""

	while true; do
		read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Pilih teknik pemulihan kata sandi file ZIP: ' pilih_teknik_zip

		if [[ "${pilih_teknik_zip}" == "01" ]]; then
			memulihkan_kata_sandi_file_zip_brute
			break
		elif [[ "${pilih_teknik_zip}" == "02" ]]; then
			memulihkan_kata_sandi_file_zip_dict
			break
		elif [[ "${pilih_teknik_zip}" == "03" ]]; then
			memulihkan_kata_sandi_file_zip_mask
			break
		elif [[ "${pilih_teknik_zip}" == "04" ]]; then
			memulihkan_kata_sandi_file_zip_prince
			break
		elif [[ "${pilih_teknik_zip}" == "05" ]]; then
			memulihkan_kata_sandi_file_zip_subsets
			break
		else
			echo -e "${p}[${m}-${p}] Teknik '${pilih_teknik_zip}' tidak tersedia.${r}"
			continue
		fi
	done
}

# Fungsi untuk memilih teknik pemulihan kata sandi file RAR
function memilih_teknik_pemulihan_kata_sandi_file_rar(){

	echo ""
	echo -e "${p}Teknik pemulihan kata sandi file RAR yang tersedia:${r}"
	echo ""
	echo -e "${p}[${k}01${p}] Brute Force Attack${r}"
	echo -e "${p}[${k}02${p}] Dictionary Attack${r}"
	echo -e "${p}[${k}03${p}] Mask Attack${r}"
	echo -e "${p}[${k}04${p}] Prince Attack${r}"
	echo -e "${p}[${k}05${p}] Subsets Attack${r}"
	echo ""

	while true; do
		read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Pilih teknik pemulihan kata sandi file RAR: ' pilih_teknik_rar

		if [[ "${pilih_teknik_rar}" == "01" ]]; then
			memulihkan_kata_sandi_file_rar_brute
			break
		elif [[ "${pilih_teknik_rar}" == "02" ]]; then
			memulihkan_kata_sandi_file_rar_dict
			break
		elif [[ "${pilih_teknik_rar}" == "03" ]]; then
			memulihkan_kata_sandi_file_rar_mask
			break
		elif [[ "${pilih_teknik_rar}" == "04" ]]; then
			memulihkan_kata_sandi_file_rar_prince
			break
		elif [[ "${pilih_teknik_rar}" == "05" ]]; then
			memulihkan_kata_sandi_file_rar_subsets
			break
		else
			echo -e "${p}[${m}-${p}] Teknik '${pilih_teknik_rar}' tidak tersedia.${r}"
			continue
		fi
	done
}

# Fungsi untuk memilih teknik pemulihan kata sandi file 7z
function memilih_teknik_pemulihan_kata_sandi_file_7z(){

	echo ""
	echo -e "${p}Teknik pemulihan kata sandi file 7z yang tersedia:${r}"
	echo ""
	echo -e "${p}[${k}01${p}] Brute Force Attack${r}"
	echo -e "${p}[${k}02${p}] Dictionary Attack${r}"
	echo -e "${p}[${k}03${p}] Mask Attack${r}"
	echo -e "${p}[${k}04${p}] Prince Attack${r}"
	echo -e "${p}[${k}05${p}] Subsets Attack${r}"
	echo ""

	while true; do
		read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Pilih teknik pemulihan kata sandi file 7z: ' pilih_teknik_7z

		if [[ "${pilih_teknik_7z}" == "01" ]]; then
			memulihkan_kata_sandi_file_7z_brute
			break
		elif [[ "${pilih_teknik_7z}" == "02" ]]; then
			memulihkan_kata_sandi_file_7z_dict
			break
		elif [[ "${pilih_teknik_7z}" == "03" ]]; then
			memulihkan_kata_sandi_file_7z_mask
			break
		elif [[ "${pilih_teknik_7z}" == "04" ]]; then
			memulihkan_kata_sandi_file_7z_prince
			break
		elif [[ "${pilih_teknik_7z}" == "05" ]]; then
			memulihkan_kata_sandi_file_7z_subsets
			break
		else
			echo -e "${p}[${m}-${p}] Teknik '${pilih_teknik_7z}' tidak tersedia.${r}"
			continue
		fi
	done
}

# Fungsi untuk memilih teknik pemulihan kata sandi file PDF
function memilih_teknik_pemulihan_kata_sandi_file_pdf(){

	echo ""
	echo -e "${p}Teknik pemulihan kata sandi file PDF yang tersedia:${r}"
	echo ""
	echo -e "${p}[${k}01${p}] Brute Force Attack${r}"
	echo -e "${p}[${k}02${p}] Dictionary Attack${r}"
	echo -e "${p}[${k}03${p}] Mask Attack${r}"
	echo -e "${p}[${k}04${p}] Prince Attack${r}"
	echo -e "${p}[${k}05${p}] Subsets Attack${r}"
	echo ""

	while true; do
		read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Pilih teknik pemulihan kata sandi file PDF: ' pilih_teknik_pdf

		if [[ "${pilih_teknik_pdf}" == "01" ]]; then
			memulihkan_kata_sandi_file_pdf_brute
			break
		elif [[ "${pilih_teknik_pdf}" == "02" ]]; then
			memulihkan_kata_sandi_file_pdf_dict
			break
		elif [[ "${pilih_teknik_pdf}" == "03" ]]; then
			memulihkan_kata_sandi_file_pdf_mask
			break
		elif [[ "${pilih_teknik_pdf}" == "04" ]]; then
			memulihkan_kata_sandi_file_pdf_prince
			break
		elif [[ "${pilih_teknik_pdf}" == "05" ]]; then
			memulihkan_kata_sandi_file_pdf_subsets
			break
		else
			echo -e "${p}[${m}-${p}] Teknik '${pilih_teknik_pdf}' tidak tersedia.${r}"
			continue
		fi
	done
}

# Fungsi untuk memilih teknik pemulihan kata sandi file Office
function memilih_teknik_pemulihan_kata_sandi_file_office(){

	echo ""
	echo -e "${p}Teknik pemulihan kata sandi file Office yang tersedia:${r}"
	echo ""
	echo -e "${p}[${k}01${p}] Brute Force Attack${r}"
	echo -e "${p}[${k}02${p}] Dictionary Attack${r}"
	echo -e "${p}[${k}03${p}] Mask Attack${r}"
	echo -e "${p}[${k}04${p}] Prince Attack${r}"
	echo -e "${p}[${k}05${p}] Subsets Attack${r}"
	echo ""

	while true; do
		read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Pilih teknik pemulihan kata sandi file Office: ' pilih_teknik_office

		if [[ "${pilih_teknik_office}" == "01" ]]; then
			memulihkan_kata_sandi_file_office_brute
			break
		elif [[ "${pilih_teknik_office}" == "02" ]]; then
			memulihkan_kata_sandi_file_office_dict
			break
		elif [[ "${pilih_teknik_office}" == "03" ]]; then
			memulihkan_kata_sandi_file_office_mask
			break
		elif [[ "${pilih_teknik_office}" == "04" ]]; then
			memulihkan_kata_sandi_file_office_prince
			break
		elif [[ "${pilih_teknik_office}" == "05" ]]; then
			memulihkan_kata_sandi_file_office_subsets
			break
		else
			echo -e "${p}[${m}-${p}] Teknik '${pilih_teknik_office}' tidak tersedia.${r}"
			continue
		fi
	done
}

# Fungsi untuk menampilkan menu tentang program Jono
function tentang_program(){
	echo ""
	echo -e "${p}Jono adalah program Bash sederhana yang dirancang untuk memulihkan kata sandi file ZIP,${r}"
	echo -e "${p}RAR, 7Z, PDF, dan file Office (.docx, .xlsx, .pptx). Menggunakan John The Ripper.${r}"
	echo ""
	echo -e "${p}Dibuat oleh: ${h}fixploit03${r}"
	echo ""
        read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama...\e[0m'
	menampilkan_menu
}

# Fungsi untuk menampilkan menu yang tersedia
function menampilkan_menu(){
	membersihkan_layar_terminal
        echo -e "${b}⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⠀⠀⠀⠀⠀⠀    ${r}                               ⠀    ${r}"
	echo -e "${b}⠀⠀⠀⠀⠀⠀⠀⠀⡰⠉⠀⠀⠉⠻⢦⡀⠀⡀⠀⠀⠀  ${r}                                   ⠀${r}"
	echo -e "${b}⠀⠀⠀⠀⠀⠀⠀⣰⠁⠀⠀⠀⠀⠈⣶⣝⣺⢷⡀⠀⠀⠀ ${c}       ______  _   ______           ${r}"
	echo -e "${b}⠀⠀⠀⠀⠀⠀⢠⡗⠂⠀⠀⠀⠁⠐⠺⡌⠁⠈⠛⠂⠀⠀ ${c}      / / __ \/ | / / __ \          ${r}"
	echo -e "${b}⠀⠀⠀⢀⣠⠴⠚⠊⠉⠉⠁⠈⠉⠉⠑⠓⠦⣄⡀⠀⠀⠀ ${c} __  / / / / /  |/ / / / /          ${r}"
	echo -e "${b}⢀⣴⣾⣭⡤⢤⣤⣄⣀⣀⣀⣀⣀⣀⣠⣤⡤⢤⣭⣷⣦⡀ ${c}/ /_/ / /_/ / /|  / /_/ /           ${r}"
	echo -e "${b}⠈⢯⣿⡿⣁⡜⣨⠀⠷⣲⡞⢻⣖⠾⠀⡅⢳⣈⢿⣟⡽⠁ ${c}\____/\____/_/ |_/\____/            ${r}"
	echo -e "${b}⠀⠀⠈⠙⡟⡜⣸⡀⠀⡅⠇⠘⠢⠀⢀⣇⢣⢻⠋⠁⠀⠀ ${p} Pemulih kata sandi file            ${r}"
	echo -e "${b}⠀⠀⠀⠰⡾⡰⡏⠛⠚⠋⣉⣍⠙⠓⠛⢹⢆⢷⠆    ${p} ZIP, RAR, 7Z, PDF dan Office       ${r}"
	echo -e "${b}⠀⠀⠀⠀⢷⠡⢹⠒⢖⡬⠄⠀⢭⡲⠒⡏⠈⡾⠀⠀⠀⠀ ${p} (.docx, .xlsx, .pptx)              ${r}"
	echo -e "${b}⠀⠀⠀⠀⠸⢇⣏⣦⠀⠀⠀⠀⠀⠀⣴⣽⡼⠇⠀⠀⠀  ${h} https://github.com/fixploit03/Jono/${r}"
	echo -e "${b}⠀⠀⠀⠀⠀⠈⠈⠉⠻⣴⠀⠀⣤⠟⠁⠁⠁⠀⠀⠀⠀⠀ ${r}"
	echo -e "${b}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀ ${r}"
	echo ""
	echo -e "${p}     [${k}00${p}] Keluar program Jono                                   ${r}"
	echo -e "${p}     [${k}01${p}] Ekstrak hash file ZIP                                 ${r}"
	echo -e "${p}     [${k}02${p}] Ekstrak hash file RAR                                 ${r}"
	echo -e "${p}     [${k}03${p}] Ekstrak hash file 7z                                  ${r}"
	echo -e "${p}     [${k}04${p}] Ekstrak hash file PDF                                 ${r}"
	echo -e "${p}     [${k}05${p}] Ekstrak hash file Office (.docx, .xlsx, .pptx)        ${r}"
	echo -e "${p}     [${k}06${p}] Pulihkan kata sandi file ZIP                          ${r}"
	echo -e "${p}     [${k}07${p}] Pulihkan kata sandi file RAR                          ${r}"
	echo -e "${p}     [${k}08${p}] Pulihkan kata sandi file 7Z                           ${r}"
	echo -e "${p}     [${k}09${p}] Pulihkan kata sandi file PDF                          ${r}"
	echo -e "${p}     [${k}10${p}] Pulihkan kata sandi file Ofiice (.docx, .xlsx, .pptx) ${r}"
	echo -e "${p}     [${k}99${p}] Tentang program Jono                                  ${r}"
	echo ""
}

function pilih_menu(){
        while true; do
                read -p $'\e[1;37m[\e[1;34m#\e[1;37m] Pilih menu: '  pilih_menu
		# Menu keluar
                if [[  "${pilih_menu}" == "00" ]]; then
			keluar
		# Menu ekstrak hash file zip
		elif [[ "${pilih_menu}" == "01" ]]; then
			banner_ekstrak_hash_file_zip
			memasukkan_file_zip
			ekstrak_hash_file_zip
		# Menu ekstrak hash file RAR
		elif [[ "${pilih_menu}" == "02" ]]; then
			banner_ekstrak_hash_file_rar
			memasukkan_file_rar
			ekstrak_hash_file_rar
		# Menu ekstrak hash file 7z
		elif [[ "${pilih_menu}" == "03" ]]; then
			banner_ekstrak_hash_file_7z
			memasukkan_file_7z
			ekstrak_hash_file_7z
		# Menu ekstrak hash file PDF
		elif [[ "${pilih_menu}" == "04" ]]; then
			banner_ekstrak_hash_file_pdf
			memasukkan_file_pdf
			ekstrak_hash_file_pdf
		# Menu ekstrak hash file Office
		elif [[ "${pilih_menu}" == "05" ]]; then
			banner_ekstrak_hash_file_office
			memasukkan_file_office
			ekstrak_hash_file_office
		# Menu memulihkan kata sandi file ZIP
		elif [[ "${pilih_menu}" == "06" ]]; then
			banner_pulihkan_kata_sandi_file_zip
			memasukkan_file_hash_file_zip
			memilih_teknik_pemulihan_kata_sandi_file_zip
		# Menu memulihkan kata sandi file RAR
		elif [[ "${pilih_menu}" == "07" ]]; then
			banner_pulihkan_kata_sandi_file_rar
			memasukkan_file_hash_file_rar
			memilih_teknik_pemulihan_kata_sandi_file_rar
		# Menu memulihkan kata sandi file 7z
		elif [[ "${pilih_menu}" == "08" ]]; then
			banner_pulihkan_kata_sandi_file_7z
			memasukkan_file_hash_file_7z
			memilih_teknik_pemulihan_kata_sandi_file_7z
		# Menu memulihkan kata sandi file PDF
                elif [[ "${pilih_menu}" == "09" ]]; then
			banner_pulihkan_kata_sandi_file_pdf
			memasukkan_file_hash_file_pdf
			memilih_teknik_pemulihan_kata_sandi_file_pdf
		# Menu memulihkan kata sandi file Office
                elif [[ "${pilih_menu}" == "10" ]]; then
			banner_pulihkan_kata_sandi_file_office
			memasukkan_file_hash_file_office
			memilih_teknik_pemulihan_kata_sandi_file_office
		# Menu tentang program Jono
                elif [[ "${pilih_menu}" == "99" ]]; then
			banner_tentang_program_jono
			tentang_program
		else
			echo -e "${p}[${m}-${p}] Menu '${pilih_menu}' tidak tersedia. Silahkan pilih kembali.${r}"
			continue
		fi
	done
}


# Fungsi utama
function utama(){
	# Memanggil fungsi mengecek_root
	mengecek_root
	# Memanggil fungdi membuat_folder_file_hash
	membuat_folder_file_hash
	# Memanggil fungsi menampilkan_kata_kata_peringatan
	menampilkan_kata_kata_peringatan
	# Memanggil fungsi konfirmasi
	konfirmasi
	# Memanggil fungsi mengecek_sistem_operasi
	mengecek_sistem_operasi
	# Memanggil fungsi mengecek_alat
	mengecek_alat
	# Memanggil fungsi menampilkan_menu
	menampilkan_menu
	# Memanggil fungsi pilih_menu
	pilih_menu
}

# Memanggil fungsi utama
utama
