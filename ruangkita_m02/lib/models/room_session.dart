class RoomSession {
  final String id;
  final String title;
  final String roomName;
  final String time;
  final String status; // 'Berlangsung', 'Akan Datang', 'Selesai', 'Tersedia'
  final String description;
  final String lecturer;
  final int capacity;

  const RoomSession({
    required this.id,
    required this.title,
    required this.roomName,
    required this.time,
    required this.status,
    required this.description,
    required this.lecturer,
    required this.capacity,
  });

  static List<RoomSession> getDummyData() {
    return const [
      RoomSession(
        id: 'RS01',
        title: 'Praktikum Pemrograman Perangkat Bergerak Lanjut', // > 35 karakter
        roomName: 'Lab Praktikum Mobile 1',
        time: '08.00 - 10.30',
        status: 'Berlangsung',
        description:
            'Implementasi layout deklaratif, box constraints, flex, stack, dan responsif dashboard pada Flutter.', // > 90 karakter
        lecturer: 'Sepyan Purnama Kristanto, M.Kom.',
        capacity: 32,
      ),
      RoomSession(
        id: 'RS02',
        title: 'Praktikum Elektronika Terapan & Sistem Tertanam IoT',
        roomName: 'Lab Perangkat & Mikroprosesor',
        time: '10.30 - 12.30',
        status: 'Akan Datang',
        description:
            'Pengujian sirkuit sensor mikrokontroler ESP32 serta pengiriman telemetri data nirkabel secara berkala.',
        lecturer: 'Tim Dosen Elektronika',
        capacity: 28,
      ),
      RoomSession(
        id: 'RS03',
        title: 'Praktikum Rekayasa Perangkat Lunak',
        roomName: 'Lab Pemrograman 2',
        time: '08.00 - 10.00',
        status: 'Selesai',
        description:
            'Pemodelan Unified Modeling Language (UML) dan dokumentasi rancangan sistem arsitektur berbasis komponen modular.',
        lecturer: 'Tim Dosen RPL',
        capacity: 30,
      ),
      RoomSession(
        id: 'RS04',
        title: 'Ruang Bebas Mandiri',
        roomName: 'Lab Desain Antarmuka UI/UX',
        time: '12.00 - 16.00',
        status: 'Tersedia',
        description:
            'Fasilitas workstation desain grafis dan prototyping terbuka untuk kegiatan pengerjaan tugas mandiri mahasiswa.',
        lecturer: 'Laboran Pengelola',
        capacity: 25,
      ),
      RoomSession(
        id: 'RS05',
        title:
            'Praktikum Jaringan Komputer & Administrasi Server Skalabilitas Tinggi', // > 35 karakter
        roomName: 'Lab Praktikum Mobile 1',
        time: '13.00 - 15.30',
        status: 'Akan Datang',
        description:
            'Simulasi routing dinamis OSPF, pengujian firewall IPTables, dan konfigurasi Load Balancer Nginx pada cluster Linux Server.', // > 90 karakter
        lecturer: 'Tim Dosen Jaringan',
        capacity: 32,
      ),
      RoomSession(
        id: 'RS06',
        title: 'Praktikum Basis Data Terdistribusi',
        roomName: 'Lab Pemrograman 2',
        time: '10.30 - 12.30',
        status: 'Berlangsung',
        description:
            'Praktik replikasi master-slave data transaksi berkecepatan tinggi serta indexing query pada sistem database relasional modern.',
        lecturer: 'Tim Dosen Basis Data',
        capacity: 30,
      ),
      RoomSession(
        id: 'RS07',
        title: 'Praktikum Interaksi Manusia Komputer',
        roomName: 'Lab Desain Antarmuka UI/UX',
        time: '08.00 - 10.00',
        status: 'Selesai',
        description:
            'Evaluasi usability testing dan perancangan antarmuka pengguna berbasis standar WCAG 2.1 tingkat AA.',
        lecturer: 'Tim Dosen Desain',
        capacity: 25,
      ),
      RoomSession(
        id: 'RS08',
        title: 'Ruang Uji Coba Hardware',
        roomName: 'Lab Perangkat & Mikroprosesor',
        time: '14.00 - 17.00',
        status: 'Tersedia',
        description:
            'Penyediaan alat osiloskop digital, solder station, dan modul mikrokontroler untuk troubleshooting prototipe rangkaian elektronika.',
        lecturer: 'Laboran Elektronika',
        capacity: 20,
      ),
    ];
  }
}