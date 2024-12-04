## Mask Attack 

Menggunakan pola tertentu untuk mempersempit ruang lingkup kombinasi, biasanya dengan memanfaatkan karakteristik kata sandi (misalnya, panjang dan jenis karakter).

**Contoh**: Jika kata sandi memiliki pola `Huruf besar + 3 angka`, misalnya `A123`, maka pola mask dapat ditulis sebagai:

- Mask: `?u?d?d?d`
- Kombinasi yang akan diuji:
  - `A123`
  - `B456`
  - `C789` ... hingga menemukan kecocokan.
 
Mask Penjelasan:

- `?l` = huruf kecil (a-z)
- `?u` = huruf besar (A-Z)
- `?d` = angka (0-9)
- `?s` = simbol ($, -, #, dll.)
- `?a` = semua karakter (huruf, angka, simbol).
