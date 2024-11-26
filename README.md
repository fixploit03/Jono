# Jono

[![Dikembangkan](https://img.shields.io/badge/Dikembangkan%20di-Kali%20Linux-blue)](https://www.kali.org/)
[![lisensi](https://img.shields.io/badge/Lisensi-MIT-blue)](https://github.com/fixploit03/CrackStego/blob/main/LICENSE)
[![Ditenagai](https://img.shields.io/badge/Ditenagai%20oleh-John%20The%20Ripper-red)](https://github.com/openwall/john)

`Jono` adalah program Bash sederhana yang dirancang untuk memulihkan kata sandi file ZIP, RAR, 7Z, PDF, dan file Office (.docx, .xlsx, .pptx). Menggunakan John The Ripper.

> Peringatan: Program ini dirancang hanya untuk tujuan pendidikan dan penelitian yang sah. Dilarang keras menggunakan program ini untuk kegiatan ilegal, merusak, atau tanpa izin pemilik file. Pengguna bertanggung jawab penuh atas segala konsekuensi hukum yang mungkin timbul dari penggunaan program ini. Pastikan untuk selalu mematuhi peraturan dan etika yang berlaku di wilayah Anda.

## Demo

![](https://github.com/fixploit03/Jono/blob/main/demo_jono.gif)

## Instalasi 

> Pastikan Anda sudah berada dalam mode superuser (root) sebelum memulai proses instalasi.

```sh
$ apt-get update
$ apt-get install git
$ git clone https://github.com/fixploit03/Jono.git
$ cd Jono
$ chmod +x instal_john.sh jono.sh
$ ./instal_john.sh
$ ./jono
```


> **Catatan**
> 1. Program ini hanya dapat dijalankan di sistem operasi Kali Linux.
> 2. Program ini menggunakan teknik serangan dictionary attack, di mana keberhasilan menemukan kata sandi tergantung pada isi file wordlist yang digunakan.

## Screenshot 

<p align="center">
  <img src="https://github.com/fixploit03/Jono/blob/main/aset/Screenshot_2024-11-27_00_20_15.png" />
  Kali Linux 2024.3
</p>

<p align="center">
  <img src="https://github.com/fixploit03/Jono/blob/main/aset/Screenshot%20from%202024-11-27%2000-09-08.png" />
  Linux Ubuntu 20.04
</p>

## Lisensi 

Program ini dilisensikan di bawah [Lisensi MIT](https://github.com/fixploit03/Jono/blob/main/LICENSE).

## Credits

Program ini menggunakan [John the Ripper](https://github.com/openwall/john), yang dikembangkan oleh Openwall.


**Selamat mencoba!**
