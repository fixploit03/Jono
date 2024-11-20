# Jono

[![Dikembangkan](https://img.shields.io/badge/Dikembangkan%20di-Kali%20Linux-blue)](https://www.kali.org/)
[![lisensi](https://img.shields.io/badge/Lisensi-MIT-blue)](https://github.com/fixploit03/CrackStego/blob/main/LICENSE)

Jono adalah program Bash sederhana yang dirancang untuk memulihkan kata sandi file ZIP, RAR, 7Z, PDF, dan file Office (.docx, .xlsx, .pptx). Menggunakan John The Ripper.

> Peringatan: Program ini dirancang hanya untuk tujuan pendidikan dan penelitian yang sah. Dilarang keras menggunakan program ini untuk kegiatan ilegal, merusak, atau tanpa izin pemilik file. Pengguna bertanggung jawab penuh atas segala konsekuensi hukum yang mungkin timbul dari penggunaan program ini. Pastikan untuk selalu mematuhi peraturan dan etika yang berlaku di wilayah Anda.

## Instalasi 

> Pastikan Anda sudah berada dalam mode superuser (root) sebelum memulai proses instalasi.

```
$ apt-get install bash git
$ git clone https://github.com/fixploit03/Jono.git
$ cd Jono
$ bash jono.sh
```

> **Catatan**
> 1. Program ini hanya dapat dijalankan di sistem operasi Kali Linux.
> 2. Program ini menggunakan teknik serangan dictionary attack, di mana keberhasilan menemukan kata sandi tergantung pada isi file wordlist yang digunakan.

## Lisensi 

Program ini dilisensikan di bawah [Lisensi MIT](https://github.com/fixploit03/Jono/blob/main/LICENSE).

## Screenshot 

![](https://github.com/fixploit03/Jono/blob/main/menu.png)
<p align="center">[ Menu utama Jono ]</p>

![](https://github.com/fixploit03/Jono/blob/main/ekstrak%20hash%20file%20zip.png)
<p align="center">[ Menu ekstrak hash file ZIP ]</p>

![](https://github.com/fixploit03/Jono/blob/main/pulihkan%20kata%20sandi%20file%20zip.png)
<p align="center">[ Menu pulihkan kata sandi file ZIP ]</p>

## Credits

Program ini menggunakan [John the Ripper](https://github.com/openeall/john), yang dikembangkan oleh Openwall.


**Selamat mencoba!**
