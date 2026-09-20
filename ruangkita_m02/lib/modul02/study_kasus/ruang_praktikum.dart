import 'package:flutter/material.dart';
import '../../models/room_session.dart';

class RuangPraktikumPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const RuangPraktikumPage({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<RuangPraktikumPage> createState() => _RuangPraktikumPageState();
}

class _RuangPraktikumPageState extends State<RuangPraktikumPage> {
  final List<RoomSession> _allSessions = RoomSession.getDummyData();
  String _selectedFilter = 'Semua';

  // CATATAN: Ganti 'XXXX' dengan 4 digit terakhir NIM Anda (contoh: M02-0043)
  static const String identityCode = 'M02-XXXX';

  List<RoomSession> get _filteredSessions {
    if (_selectedFilter == 'Semua') return _allSessions;
    return _allSessions.where((s) => s.status == _selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Berlangsung':
        return const Color(0xFF0284C7);
      case 'Akan Datang':
        return const Color(0xFFD97706);
      case 'Selesai':
        return const Color(0xFF64748B);
      case 'Tersedia':
        return const Color(0xFF16A34A);
      default:
        return Colors.blueGrey;
    }
  }

  void _showDetailBottomSheet(BuildContext context, RoomSession session) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    session.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Chip(
                        label: Text(session.status),
                        backgroundColor: _getStatusColor(session.status).withOpacity(0.15),
                        labelStyle: TextStyle(
                          color: _getStatusColor(session.status),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Chip(
                        avatar: const Icon(Icons.people_outline, size: 16),
                        label: Text('Kapasitas: ${session.capacity} kursi'),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.meeting_room, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          session.roomName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 18),
                      const SizedBox(width: 8),
                      Text(session.time),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18),
                      const SizedBox(width: 8),
                      Text('Pengampu: ${session.lecturer}'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Deskripsi Kegiatan:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    session.description,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text('Tutup Rincian'),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCard(RoomSession session) {
    final statusColor = _getStatusColor(session.status);

    return InkWell(
      onTap: () => _showDetailBottomSheet(context, session),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Padding kanan agar teks judul tidak tertimpa badge status di Stack
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
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          session.time,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          session.roomName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      session.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Indikator Badge Overlay menggunakan Stack & Positioned
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  session.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.dashboard_outlined,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Ringkasan Hari Ini',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text('• Total Jadwal: ${_allSessions.length} sesi'),
          const SizedBox(height: 6),
          Text(
              '• Sedang Berlangsung: ${_allSessions.where((s) => s.status == 'Berlangsung').length} ruang'),
          const SizedBox(height: 6),
          Text(
              '• Tersedia Kosong: ${_allSessions.where((s) => s.status == 'Tersedia').length} ruang'),
          const SizedBox(height: 6),
          Text(
              '• Telah Selesai: ${_allSessions.where((s) => s.status == 'Selesai').length} ruang'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RuangKita - Ruang Praktikum'),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                identityCode,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
            tooltip: 'Ubah Tema',
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 600;
          final isMedium = constraints.maxWidth >= 600 && constraints.maxWidth < 840;
          final isExpanded = constraints.maxWidth >= 840;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['Semua', 'Berlangsung', 'Akan Datang', 'Tersedia', 'Selesai']
                      .map(
                        (filter) => ChoiceChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedFilter = filter);
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),

                if (isCompact)
                  Column(
                    children: _filteredSessions
                        .map((s) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildCard(s),
                            ))
                        .toList(),
                  )
                else if (isMedium)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.85,
                    ),
                    itemCount: _filteredSessions.length,
                    itemBuilder: (context, index) => _buildCard(_filteredSessions[index]),
                  )
                else if (isExpanded)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.9,
                          ),
                          itemCount: _filteredSessions.length,
                          itemBuilder: (context, index) =>
                              _buildCard(_filteredSessions[index]),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: _buildSummaryPanel(),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}