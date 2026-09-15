import 'package:flutter/material.dart';

// import 'modul_02/academic_dashboard_screen.dart';
import 'modul_02/studikasus/ruangpraktikum.dart';

void main() {
  runApp(const PoliwangiMobileApp());
}

class PoliwangiMobileApp extends StatelessWidget {
  const PoliwangiMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Mobile TRPL Poliwangi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      home: const ModuleLauncherScreen(),
    );
  }
}

class ModuleLauncherScreen extends StatefulWidget {
  const ModuleLauncherScreen({super.key});

  @override
  State<ModuleLauncherScreen> createState() => _ModuleLauncherScreenState();
}

class _ModuleLauncherScreenState extends State<ModuleLauncherScreen> {
  // Status pembukaan modul
  bool _isModul02Unlocked = false;

  void _handleUnlockModul02() {
    if (_isModul02Unlocked) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RuangPraktikumScreen()),
      );
      return;
    }

    final TextEditingController tokenController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Masukkan Token Akses Kelas'),
        content: TextField(
          controller: tokenController,
          decoration: const InputDecoration(
            hintText: 'Contoh: TRPL-M02 atau POLIWANGI2026',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              final token = tokenController.text.trim();
              if (token == 'TRPL-M02' || token == 'POLIWANGI2026') {
                setState(() {
                  _isModul02Unlocked = true;
                });
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RuangPraktikumScreen(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Token salah! Gunakan TRPL-M02 atau POLIWANGI2026',
                    ),
                  ),
                );
              }
            },
            child: const Text('Buka Modul'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Peta Modul Praktikum Mobile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Pilih modul yang sedang aktif di laboratorium:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 12),
          // Modul 01
          Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('Modul 01: Mobile Ecosystem & Setup'),
              subtitle: const Text('Status: Selesai / Aktif'),
            ),
          ),
          const SizedBox(height: 8),
          // Modul 02
          Card(
            elevation: 3,
            child: ListTile(
              leading: Icon(
                _isModul02Unlocked
                    ? Icons.lock_open_rounded
                    : Icons.lock_outline_rounded,
                color: _isModul02Unlocked ? Colors.blue : Colors.orange,
              ),
              title: const Text(
                'Modul 02: Declarative UI & Responsive Layout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _isModul02Unlocked
                    ? 'Akses Terbuka — Klik untuk masuk'
                    : 'Terkunci — Masukkan Token Akses',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: _handleUnlockModul02,
            ),
          ),
        ],
      ),
    );
  }
}
