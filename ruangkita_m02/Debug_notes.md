# DEBUG NOTES - MODUL 02 (RuangKita)
**Nama**: Taufiq Hidayat  
**NIM**: 362558302103  
**Domain**: Ruang Praktikum  
**Identitas**: M02-2103

Dokumentasi minimal 2 kasus permasalahan nyata selama proses pengembangan antarmuka deklaratif dan responsif.

---

## Kasus 1: RenderFlex Overflow pada Judul Teks Panjang & Tabrakan dengan Badge

### 1. Gejala Masalah
Saat menguji data teks panjang (> 35 karakter) pada judul sesi praktikum di mode Compact (layar mobile lebar 360 dp), muncul garis strip kuning-hitam (*RenderFlex overflowed by X pixels*). Selain itu, teks judul melebar ke sisi kanan sehingga menimpa indikator badge status yang dipasang menggunakan `Stack` dan `Positioned`.

### 2. Bukti Screenshot
- **Sebelum Perbaikan**: Terjadi overflow visual di sisi kanan judul kartu.
- **Sesudah Perbaikan**: Teks terpotong rapi dengan elipsis tanpa menabrak badge status (`screenshots/01_mobile_light.PNG`).

### 3. Dugaan Akar Masalah
Secara default, widget `Text` di dalam `Column` akan mengukur panjang teks berdasarkan intrinsik konten. Karena badge diletakkan sebagai layer overlay (`Positioned`) di kanan atas selebar ±80 dp, teks judul yang panjang tidak menyadari adanya badge tersebut dan tetap mengambil lebar penuh kontainer, memicu tabrakan visual dan overflow.

### 4. Perubahan Kode (Solusi)
Membungkus `Text` judul dengan `Padding(padding: EdgeInsets.only(right: 95.0))` untuk memberikan batas aman bagi badge `Positioned`, serta menambahkan properti `maxLines: 2` dan `overflow: TextOverflow.ellipsis`.

```dart
// Sebelum:
Text(session.title, style: TextStyle(fontWeight: FontWeight.bold))

// Sesudah:
Padding(
  padding: const EdgeInsets.only(right: 95.0),
  child: Text(
    session.title,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  ),
)
```
## Kasus 2: Konten Kartu Melar Berlebihan pada Grid View Tablet (Child Aspect Ratio)

### 1. Gejala Masalah
Ketika breakpoint medium (lebar 720 dp) aktif, GridView.builder dengan 2 kolom menampilkan kartu dengan ruang kosong vertikal (whitespace) yang terlalu besar di bagian bawah kartu. Tampilan menjadi tidak proporsional dan boros ruang vertikal.

### 2. Bukti Screenshot
- **Sebelum Perbaikan**: Kartu terlalu tinggi dan menyisakan banyak ruang kosong di bawah deskripsi.
- **Sesudah Perbaikan**: Proporsi kartu rapat dan seimbang (screenshots/02_tablet.png).(`screenshots/02_tablet.PNG`).

### 3. Dugaan Akar Masalah
Parameter default childAspectRatio pada SliverGridDelegateWithFixedCrossAxisCount bernilai 1.0 (persegi sama sisi). Rumus childAspectRatio adalah $\text{Lebar} / \text{Tinggi}$. Nilai yang terlalu kecil membuat kontainer kartu dipaksa memiliki tinggi yang berlebihan oleh constraints parent grid.

### 4. Perubahan Kode (Solusi)
Menyesuaikan nilai childAspectRatio menjadi 1.85 pada mode medium dan 1.9 pada mode expanded agar tinggi kartu pas membungkus konten teks di dalamnya.
```dart
// Sebelum:
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  childAspectRatio: 1.0, // default
)

// Sesudah:
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 14,
  mainAxisSpacing: 14,
  childAspectRatio: 1.85,
)