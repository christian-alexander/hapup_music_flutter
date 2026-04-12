# HappyMusic
Project ini dibuat sebagai bagian dari technical test untuk posisi Programmer di PT. Imperium Happy Puppy. Fokus utama adalah membangun sistem manajemen lagu sederhana dengan perhatian pada performa, user experience, dan scalability.

## Tech Stack
- Flutter 3.41.6
- penyimpanan data : shared preferences dan sqflite

## fitur utama yang diminta 
- simple auth 
- crud daftar musik 
- filter genre
- search musik  
- sort by 

## rencana improvement 
1. aplikasi production pasti tak lepas dari API, jika dikembangkan lebih lanjut perlu API call ke backend server yang terhubung ke database online 
2. secara ui/ux bisa lebih ditingkatkan
3. fitur dan kebutuhan bisa lebih spesifik dan lengkap agar bisa dipakai untuk production, sesuai dengan business logic yang ditentukan perusahaan

---

# Dependencies
- shared preferences 
- sqflite
- material design (use)
- flutter launcher icons

--- 
# Installation
## Requirement
1. flutter sdk 
2. android studio + android sdk 
3. vs code (opsional) atau android studio

## Cara Install 
NOTE : Harap jangan menjalankan flutter ini di web, karena plugin sqflite yang tidak stabil di web.
1. git clone ke folder di pc 
2. masuk ke folder hasil clone, jalankan `flutter pub get`
3. jalankan `flutter create .`
4. siapkan device android dan nyalakan usb debugging dan install via usb (pastikan developer mode menyala)
5. tancapkan device dan jalankan `flutter devices`, pastikan device sudah tampil
6. run debug. jika di vs code bisia klik f5. atau klik run jika di android studio

## demo account 
- email : admin@gmail.com 
- password : admin

--- 
# Struktur Code 
code utamanya ada di /lib 
## Entry point 
1. lib/main.dart -> untuk entry point saat run app

## services 
1. lib/auth_service.dart -> untuk service terkait perloginan, untuk login sederhana menggunakan shared preferences
2. lib/music_service.dart -> menghandle terkait pertukaran data dengan database sqflite

## pages 
1. lib/pages/login.dart -> untuk login page
2. lib/pages/splash.dart -> ketika app pertama kali dibuka, kesini dulu untuk cek sudah login / tidak, nanti di navigate ke login / dashboard berdasarkan status authnya
3. lib/pages/music/music_list.dart -> halaman dashboard utama list musik dengan filter, search, dan orderby
4. lib/pages/music/music_form.dart -> halaman form untuk tambah / edit musik

--- 
# Business logic 
## login
1. Login melalui halaman login dengan mengisikan email dan password 
2. diverifikasi manual status auth disimpan di shared preferences  
3. jika credential salah -> muncul alert kredensial salah dan diminta login ulang 
4. jika credential benar -> navigate ke halaman music list after login

## Music 
### index 
untuk ke halaman ini, user harus login terlebih dahulu.
1. secara default, menampilkan all music dari all genre, tanpa filter search, dan order by judul lagu asc 
2. user bisa search, filter genre, dan order by di fitur yang tersedia

### Add
1. ketika user klik tombol tambah di index bagian kanan bawah, akan navigate ke halaman form musik
2. user isi dan klik tombol tambah -> validasi inputan
3. jika salah, akan muncul alert dan kembali ke poin #2
4. jika benar akan proses tambah musik oleh music_service

### Edit
1. ketika user klik tombol edit di masing masing music card, akan navigate ke halaman form musik
2. user ubah data dan klik tombol ubah -> validasi inputan
3. jika salah, akan muncul alert dan kembali ke poin #2
4. jika benar akan proses ubah musik oleh music_service

### delete
1. ketika user klik tombol delete di masing masing music card, akan muncul validasi box konfirmasi
2. jika cancel, box tertutup
3. jika konfirm, akan diproses hapus oleh music service

--- 
### Screenshots
<img src="https://raw.githubusercontent.com/christian-alexander/hapup_music_flutter/refs/heads/main/docs/9.jpeg">
Login page
<img src="https://raw.githubusercontent.com/christian-alexander/hapup_music_flutter/refs/heads/main/docs/8.jpeg">
Index
<img src="https://raw.githubusercontent.com/christian-alexander/hapup_music_flutter/refs/heads/main/docs/7.jpeg">
Urutkan
<img src="https://raw.githubusercontent.com/christian-alexander/hapup_music_flutter/refs/heads/main/docs/6.jpeg">
Filter Genre
<img src="https://raw.githubusercontent.com/christian-alexander/hapup_music_flutter/refs/heads/main/docs/5.jpeg">
Search
<img src="https://raw.githubusercontent.com/christian-alexander/hapup_music_flutter/refs/heads/main/docs/4.jpeg">
Popup logout
<img src="https://raw.githubusercontent.com/christian-alexander/hapup_music_flutter/refs/heads/main/docs/3.jpeg">
Popup Hapus
<img src="https://raw.githubusercontent.com/christian-alexander/hapup_music_flutter/refs/heads/main/docs/2.jpeg">
Form Tambah
<img src="https://raw.githubusercontent.com/christian-alexander/hapup_music_flutter/refs/heads/main/docs/1.jpeg">
Form Ubah