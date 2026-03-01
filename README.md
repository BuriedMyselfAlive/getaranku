# Getaranku

Getaranku adalah aplikasi pendeteksi getaran berbasis flutter.

## Getting Started

Sensor getaran berbasis IoT adalah sebuah sistem yang menggunakan LORA sebagai komunikasi data, Raspberry Pi untuk server LORA, GPS untuk mendeteksi lokasi, Baterai, Microcontroller ESP32, untuk mendeteksi dan memberikan peringatan saat terjadi adanya getaran. Sistem ini dirancang untuk mengirimkan infomasi getaran ke aplikasi Getaranku.

Dengan menggunakan sensor Omron D7S, sistem ini dapat mendeteksi  getaran pada infrastruktur dan aktivitas manusia yang berlebihan. Ketika getaran terdeteksi, sistem akan mengirimkan data dari LORA ke Raspi yang ditujukan sebagai server, kemudian data akan ditampilkan pada aplikasi Getaranku. 
Sistem ini juga dilengkapi dengan kemampuan untuk mengirimkan informasi besarnya getaran dalam satuan SI ( Seismic Intensity / Spectrum Intensity ). 

Dalam aplikasi Getaranku, ketika level getaran masih aman / rendah yang bernilai 1,0 - 2,9 SI tidak bisa dirasakan oleh manusia, 3,0 - 3,9 SI hanya dapat dirasakan oleh manusia di sekitar pusat getaran, 4,0 - 4,9 SI sangat terasa getarannya, 5,0 - 5,9 SI manusia sudah tidak bisa berdiri tegak, 6,0 SI sampai seterusnya infrastruktur sudah mulai runtuh.


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
