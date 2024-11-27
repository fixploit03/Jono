<h1 align="center">
  <img src="https://github.com/fixploit03/Jono/blob/main/aset/20241127_102430.png" width=100 height=100/><br>
Jono</h1>

<p align="center">
  <span>Pemulih kata sandi file ZIP, RAR, 7Z, PDF, dan file Office (.docx, .xlsx, .pptx) yang ditenagai oleh <a href="https://github.com/openwall/john" >John The Ripper</a></span>
</p>

<p align="center">
  <a href="https://github.com/fixploit03/Jono#instalasi">Instalasi</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/fixploit03/Jono#demonstrasi">Demonstrasi</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/fixploit03/Jono#credits">Credits</a>
</p>

  <p align="center">
    <a href="https://www.kali.org/"><img alt="Dikembangkan" src="https://img.shields.io/badge/Dikembangkan%20di-Kali%20Linux-blue"></a>
    <a href="https://github.com/fixploit03/Jono/blob/main/LICENSE"><img alt="Lisensi" src="https://img.shields.io/badge/Lisensi-MIT-blue"></a>
  </p>

# Jono

[![Dikembangkan]()]()
[![lisensi]()]()
[![Ditenagai](https://img.shields.io/badge/Ditenagai%20oleh-John%20The%20Ripper-red)](https://github.com/openwall/john)

`Jono` adalah program Bash sederhana yang dirancang untuk memulihkan kata sandi file ZIP, RAR, 7Z, PDF, dan file Office (.docx, .xlsx, .pptx). Menggunakan John The Ripper.

> Peringatan: Program ini dirancang hanya untuk tujuan pendidikan dan penelitian yang sah. Dilarang keras menggunakan program ini untuk kegiatan ilegal, merusak, atau tanpa izin pemilik file. Pengguna bertanggung jawab penuh atas segala konsekuensi hukum yang mungkin timbul dari penggunaan program ini. Pastikan untuk selalu mematuhi peraturan dan etika yang berlaku di wilayah Anda.

## Demonstrasi 

Video demonstrasi penggunaan program Jono dapat dilihat [di sini](https://youtu.be/NhDhM8yXHFw?si=lM3pWlp10KDU0hcZ).

## Instalasi 

> Pastikan Anda sudah berada dalam mode superuser (root) sebelum memulai proses instalasi.

```sh
$ apt-get update
$ apt-get install python3
$ apt-get install git
$ git clone https://github.com/fixploit03/Jono.git
$ cd Jono
$ ln -s /usr/bin/python3 /usr/bin/python
$ chmod +x instal_john.sh jono.sh
$ ./instal_john.sh
$ ./jono
```

## Screenshot 

<p align="center">
  <img src="https://github.com/fixploit03/Jono/blob/main/aset/Screenshot_2024-11-27_00_20_15.png" />
  Kali Linux 2024.3
</p>

<p align="center">
  <img src="https://github.com/fixploit03/Jono/blob/main/aset/Screenshot%20from%202024-11-27%2000-09-08.png" />
  Linux Ubuntu 20.04
</p>

> **Catatan**: Program ini menggunakan teknik serangan dictionary attack, di mana keberhasilan menemukan kata sandi tergantung pada isi file wordlist yang digunakan.

## Lisensi 

Program ini dilisensikan di bawah [Lisensi MIT](https://github.com/fixploit03/Jono/blob/main/LICENSE).

## Credits

Program ini menggunakan [John the Ripper](https://github.com/openwall/john), yang dikembangkan oleh Openwall.


**Selamat mencoba!**
