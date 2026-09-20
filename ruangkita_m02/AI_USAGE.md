```markdown
# AI USAGE DECLARATION - MODUL 02

**Nama**: Taufiq Hidayat  
**NIM**: 362558302103  
**Domain**: Ruang Praktikum  
**Mata Kuliah**: Pemrograman Perangkat Bergerak  

---

### 1. Alat / Model yang Digunakan
- **Model**: Google Gemini  
- **Peran**: Asisten teknis, referensi debugging constraints Flutter, dan peninjau arsitektur layout deklaratif.

### 2. Tujuan Penggunaan
- Membantu penyusunan skema arsitektur responsive 3 breakpoint (`LayoutBuilder`) sesuai panduan modul.
- Memvalidasi penggunaan kombinasi `Stack`, `Positioned`, dan `Flex` agar tidak menimbulkan `RenderFlex overflow`.
- Menyusun struktur data model dummy yang memenuhi syarat batasan teks panjang.

### 3. Ringkasan Prompt yang Digunakan
- *"Bagaimana menyusun LayoutBuilder dengan 3 kondisi: compact (<600dp), medium (600-839dp), dan expanded (>=840dp) di Flutter?"*
- *"Mengapa teks panjang di dalam kartu bertabrakan dengan Positioned badge dan bagaimana penanganan constraints-nya?"*
- *"Bagaimana mengintegrasikan showModalBottomSheet dengan StatefulBuilder untuk menampilkan rincian data?"*

### 4. Bagian Kode yang Terpengaruh
- `lib/models/room_session.dart`: Format pembuatan data list objek model.
- `lib/modul02/studi_kasus/ruang_praktikum.dart`:
  - Struktur branching responsif pada `LayoutBuilder`.
  - Penempatan overlay badge menggunakan `Stack` & `Positioned`.
  - Penggunaan `Wrap` dan `ChoiceChip` untuk filter kategori lokal dengan `setState()`.

### 5. Modifikasi dan Validasi Mandiri
- Menyesuaikan nilai `childAspectRatio` pada `GridView` secara manual melalui hot-reload untuk memastikan kartu tidak terlalu tinggi pada resolusi tablet 720 dp.
- Menambahkan pembatas `Padding(right: 95)` pada judul agar label status tetap memiliki ruang aman di berbagai ukuran font.
- Menguji interaksi filter chip dan toggle tema gelap secara mandiri pada Google Chrome DevTools.
- Menggambar bagan widget tree secara langsung di atas kertas fisik untuk memahami aliran constraints sebelum mengumpulkan tugas.