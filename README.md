# Jono 

[![Platform](https://img.shields.io/badge/Platform-Kali_Linux-blue?logo=kali-linux)](https://www.kali.org/)
[![Bahasa](https://img.shields.io/badge/Bahasa-Bash-green?logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![Ditenagai oleh](https://img.shields.io/badge/Ditenagai_oleh-John_the_Ripper-red?logo=lock)](https://github.com/openwall/john)
[![Tujuan](https://img.shields.io/badge/Tujuan-Pemulihan_Kata_Sandi-lightgreen?logo=unlock)](https://www.sciencedirect.com/topics/computer-science/recovery-password)
[![Lisensi](https://img.shields.io/badge/Lisensi-MIT-green?logo=open-source-initiative)](https://github.com/fixploit03/Jono/blob/main/LICENSE)

`Jono` adalah program Bash sederhana yang dirancang untuk memulihkan kata sandi file ZIP, RAR, 7Z, PDF, dan file Office (.docx, .xlsx, .pptx). Menggunakan John The Ripper.

## Fitur Utama 

1. **Dukungan Berbagai Format File**  
   Program ini mampu memproses file yang dilindungi kata sandi dengan format berikut:
   - **ZIP**  
   - **RAR**  
   - **7Z**  
   - **PDF**  
   - **File Office** (.docx, .xlsx, .pptx)
     
2. **Beragam Teknik Pemulihan Kata Sandi**  
   Program menyediakan beberapa teknik untuk memulihkan kata sandi berdasarkan kebutuhan:
   - **[Dictionary Attack](https://github.com/fixploit03/Jono/blob/main/doc/DICT.md)**
   - **[Brute Force Attack](https://github.com/fixploit03/Jono/blob/main/doc/BRUTE.md)**
   - **[Mask Attack](https://github.com/fixploit03/Jono/blob/main/doc/MASK.md)**
   - **[Prince Attack](https://github.com/fixploit03/Jono/blob/main/doc/PRINCE.md)**
   - **[Subsets Attack](https://github.com/fixploit03/Jono/blob/main/doc/SUBSETS.md)**

3. **Antarmuka Interaktif**
   - Mudah digunakan melalui menu berbasis terminal.  

## Persyaratan Sistem
- **OS**: Linux Debian/Ubuntu `disarankan Kali Linux`.
- **Hak Akses**: Harus dijalankan sebagai root.
- **Tools yang dibutuhkan**:
  - John the Ripper
  - zip2john
  - rar2john
  - 7z2john
  - pdf2john
  - office2john

## Sistem Operasi yang Mendukung

| No | Sistem Operasi | Distribusi | Status | Screenshot |
|:--:|:--:|:--:|:--:|:--:|
| 1 | Android | Debian (proot-distro Termux) | Mendukung | ![Screenshot](https://github.com/fixploit03/Jono/blob/main/screenshot/20241210_021945.jpg) |
| | | Ubuntu (proot-distro Termux) | Mendukung | ![Screenshot](https://github.com/fixploit03/Jono/blob/main/screenshot/20241210_021945.jpg) |
| 2 | Linux | Debian | Mendukung | ![Screenshot](https://github.com/fixploit03/Jono/blob/main/screenshot/screenshot_debian.png) |
| | | Ubuntu | Mendukung | ![Screenshot]() |
| | | Mint | Mendukung | ![Screenshot]() |
| | | Kali | Mendukung | ![Screenshot]() |
  
## Instalasi 
> Pastikan Anda sudah berada dalam mode superuser (root) sebelum memulai proses instalasi.

Langkah-langkah instalasi:


```sh
$ apt-get update
$ apt-get install python3
$ apt-get install git
$ git clone --depth 1 https://github.com/fixploit03/Jono.git
$ cd Jono
$ ln -s /usr/bin/python3 /usr/bin/python
$ chmod +x instal_john.sh jono.sh
$ ./instal_john.sh
```

> Untuk user Termux bisa lihat [disini](https://github.com/fixploit03/Jono/blob/main/doc/TERMUX.md).

## Menjalankan Jono:

Setelah proses instalasi selesai, Anda dapat menjalankan Jono dengan perintah:

```sh
$ ./jono.sh
```

## Peringatan Penting
**Jono** dirancang untuk tujuan **pendidikan dan penelitian** yang sah. Penggunaan alat ini untuk kegiatan ilegal, merusak, atau tanpa izin pemilik file **dilarang keras**.

- Pastikan Anda memiliki izin eksplisit untuk memulihkan kata sandi file.
- Pengguna bertanggung jawab penuh atas penggunaan alat ini dan segala konsekuensi hukum yang mungkin timbul.

## Lisensi 
Program ini dilisensikan di bawah [Lisensi MIT](https://github.com/fixploit03/Jono/blob/main/LICENSE).

## Credits
Program ini menggunakan [John the Ripper](https://github.com/openwall/john), yang dikembangkan oleh Openwall.

## Dukungan

Jika Anda menyukai program ini atau merasa bahwa program ini bermanfaat, Anda dapat mendukung proyek ini dengan cara berikut:
- **Beri bintang** pada repositori ini di GitHub untuk membantu orang lain menemukannya.
- **Beri umpan balik** dengan membuka *[issue](https://github.com/fixploit03/Jono/issues)* atau memberikan saran perbaikan.

Terima kasih telah menggunakan **Jono**! Semoga bermanfaat.
