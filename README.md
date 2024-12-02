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

![](https://github.com/fixploit03/Jono/blob/main/aset/jono.png)

`Jono` adalah program Bash sederhana yang dirancang untuk memulihkan kata sandi file ZIP, RAR, 7Z, PDF, dan file Office (.docx, .xlsx, .pptx). Menggunakan John The Ripper.

## :sparkles: Fitur Utama 

1. **Mendukung Berbagai Format File**
   Program ini dapat memproses berbagai format file yang dilindungi kata sandi, termasuk:
   - **ZIP**  
   - **RAR**  
   - **7Z**  
   - **PDF**  
   - **File Office** (.docx, .xlsx, .pptx)

2. **Metode Serangan yang Tersedia**
   - **Dictionary Attack**: Menggunakan wordlist untuk mencoba berbagai kemungkinan kata sandi.
   - **Brute Force Attack**: Memungkinkan pengguna menentukan panjang kata sandi minimal dan maksimal untuk serangan yang lebih fleksibel.

3. **Antarmuka Interaktif**
   - Mudah digunakan melalui menu berbasis terminal.  

## :package: Persyaratan Sistem
- **OS**: Linux Debian/Ubuntu `disarankan Kali Linux`.
- **Hak Akses**: Harus dijalankan sebagai root.
- **Tools yang dibutuhkan**:
  - John the Ripper
  - zip2john
  - rar2john
  - 7z2john
  - pdf2john
  - office2john
  
## :hammer_and_wrench: Instalasi 
> Pastikan Anda sudah berada dalam mode superuser (root) sebelum memulai proses instalasi.

```sh
$ apt-get update
$ apt-get install python3
$ apt-get install git
$ git clone --depth 1 https://github.com/fixploit03/Jono.git
$ cd Jono
$ ln -s /usr/bin/python3 /usr/bin/python
$ chmod +x instal_john.sh jono.sh
$ ./instal_john.sh
$ ./jono.sh
```

## :movie_camera: Demonstrasi 
Video demonstrasi penggunaan program Jono dapat dilihat [di sini](https://youtu.be/NhDhM8yXHFw?si=lM3pWlp10KDU0hcZ).

## :camera_flash: Screenshot 

<p align="center">
  <img src="https://github.com/fixploit03/Jono/blob/main/aset/Screenshot_2024-11-27_00_20_15.png" />
  Kali Linux 2024.3
</p>

<p align="center">
  <img src="https://github.com/fixploit03/Jono/blob/main/aset/Screenshot%20from%202024-11-27%2000-09-08.png" />
  Linux Ubuntu 20.04
</p>

## :warning: Peringatan Penting
**Jono** dirancang untuk tujuan **pendidikan dan penelitian** yang sah. Penggunaan alat ini untuk kegiatan ilegal, merusak, atau tanpa izin pemilik file **dilarang keras**.

- Pastikan Anda memiliki izin eksplisit untuk memulihkan kata sandi file.
- Pengguna bertanggung jawab penuh atas penggunaan alat ini dan segala konsekuensi hukum yang mungkin timbul.

## :scroll: Lisensi 
Program ini dilisensikan di bawah [Lisensi MIT](https://github.com/fixploit03/Jono/blob/main/LICENSE).

## :diamond_shape_with_a_dot_inside: Credits
Program ini menggunakan [John the Ripper](https://github.com/openwall/john), yang dikembangkan oleh Openwall.

**Selamat mencoba!**
