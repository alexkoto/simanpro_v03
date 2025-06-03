import 'package:flutter/material.dart';
import 'package:simanpro_v03/services/local_storage.dart';
import 'package:simanpro_v03/widgets/screen_navigator.dart';
import '../settings/notification_screen.dart';
import '../settings/setting_screen.dart';
import '../user/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Map<String, dynamic> _userData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await LocalStorage.getUserData();
    setState(() {
      _userData = userData;
      _isLoading = false;
    });
  }

  // Define all possible menu items
  final Map<String, List<Map<String, dynamic>>> _allMenuItems = {
    'dashboard': [
      {'title': 'Ringkasan Proyek', 'icon': Icons.bar_chart_outlined},
      {'title': 'Financial Overview', 'icon': Icons.bar_chart_outlined},
      {'title': 'Alert System', 'icon': Icons.notification_important_outlined},
    ],
    'project': [
      {'title': 'Daftar Proyek', 'icon': Icons.list},
      {'title': 'Timeline & Scheduling', 'icon': Icons.timeline},
      {'title': 'Document Control', 'icon': Icons.folder_open},
    ],
    'material': [
      {'title': 'Stock Management', 'icon': Icons.inventory},
      {'title': 'Purchase Order', 'icon': Icons.shopping_bag_outlined},
      {'title': 'Penggunaan Material', 'icon': Icons.build},
      {'title': 'Pengembalian Material', 'icon': Icons.undo_outlined},
    ],
    'equipment': [
      {'title': 'Equipment', 'icon': Icons.car_rental_sharp},
      {'title': 'Equipment Tracking', 'icon': Icons.location_searching},
      {'title': 'Maintenance Log', 'icon': Icons.build_circle},
      {'title': 'Fuel Monitoring', 'icon': Icons.local_gas_station},
      {'title': 'Peminjaman Kendaraan', 'icon': Icons.directions_car_filled},
      {'title': 'Jatuh Tempo Pajak & Perizinan', 'icon': Icons.event_note},
    ],
    'hr': [
      {'title': 'Absensi Online', 'icon': Icons.fingerprint},
      {'title': 'Daftar Karyawan', 'icon': Icons.people_alt_outlined},
      {'title': 'Pengajuan Cuti', 'icon': Icons.beach_access_outlined},
      {'title': 'Pengajuan Gaji', 'icon': Icons.monetization_on_outlined},
      {'title': 'Matriks Kinerja', 'icon': Icons.grid_view},
      {'title': 'Timesheet', 'icon': Icons.schedule_outlined},
      {'title': 'Laporan Kinerja', 'icon': Icons.bar_chart_outlined},
      {'title': 'Pelatihan & Pengembangan', 'icon': Icons.school_outlined},
      {
        'title': 'Payroll Management',
        'icon': Icons.account_balance_wallet_outlined,
      },
    ],
    'qc': [
      {'title': 'Inspeksi Harian', 'icon': Icons.task_alt},
      {'title': 'Laporan Insiden', 'icon': Icons.report_gmailerrorred_outlined},
      {'title': 'Audit QC', 'icon': Icons.fact_check_outlined},
    ],
    'accounting': [
      {'title': 'Progress Billing', 'icon': Icons.receipt},
      {'title': 'Biaya Operasional', 'icon': Icons.money_off},
      {'title': 'Invoice Management', 'icon': Icons.request_page},
    ],
    'report': [
      {'title': 'Daily Report', 'icon': Icons.article_outlined},
      {'title': 'Laporan Bulanan', 'icon': Icons.calendar_month},
      {'title': 'Arsip Digital', 'icon': Icons.archive_outlined},
    ],
    'field': [
      {'title': 'Photo Documentation', 'icon': Icons.photo_camera},
      {'title': 'Offline Mode', 'icon': Icons.cloud_off},
      {'title': 'Signature Capture', 'icon': Icons.edit_note},
    ],
  };

  // Get menu items based on user role
  List<Widget> _getMenuSections() {
    final roleId =
        _userData['role_id']?.toString() ?? '6'; // Default to role 6 if not set
    final sections = <Widget>[];

    // Always show dashboard
    sections.add(
      _buildSectionCard('Dashboard & Analytics', _allMenuItems['dashboard']!),
    );

    // Role-based menu items
    switch (roleId) {
      case '1': // Admin
        sections.addAll([
          _buildSectionCard('Manajemen Proyek', _allMenuItems['project']!),
          _buildSectionCard('Material & Inventory', _allMenuItems['material']!),
          _buildSectionCard(
            'Alat Berat & Kendaraan',
            _allMenuItems['equipment']!,
          ),
          _buildSectionCard('Tenaga Kerja', _allMenuItems['hr']!),
          _buildSectionCard('Quality Control', _allMenuItems['qc']!),
          _buildSectionCard('Accounting', _allMenuItems['accounting']!),
          _buildSectionCard('Laporan', _allMenuItems['report']!),
        ]);
        break;
      case '2': // Project Manager
        sections.addAll([
          _buildSectionCard('Manajemen Proyek', _allMenuItems['project']!),
          _buildSectionCard('Material & Inventory', _allMenuItems['material']!),
          _buildSectionCard('Laporan', _allMenuItems['report']!),
        ]);
        break;
      case '3': // Site Engineer
        sections.addAll([
          _buildSectionCard('Manajemen Proyek', [
            _allMenuItems['project']![0], // Only show Daftar Proyek
            _allMenuItems['project']![1], // Timeline & Scheduling
          ]),
          _buildSectionCard('Material', [
            _allMenuItems['material']![2], // Penggunaan Material
            _allMenuItems['material']![3], // Pengembalian Material
          ]),
          _buildSectionCard('Quality Control', _allMenuItems['qc']!),
        ]);
        break;
      case '6': // Default role (adjust as needed)
      default:
        sections.addAll([
          _buildSectionCard('Manajemen Proyek', [
            _allMenuItems['project']![0], // Only show Daftar Proyek
          ]),
          _buildSectionCard('Laporan', [
            _allMenuItems['report']![0], // Daily Report
          ]),
        ]);
    }

    return sections;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToScreen(
    Widget screen, {
    bool updateSelected = false,
    int? indexToSet,
  }) {
    if (updateSelected && indexToSet != null) {
      setState(() {
        _selectedIndex = indexToSet;
      });
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.person, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              'Hai ${_userData['name'] ?? 'User'}!',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
              size: 20,
            ),
            onPressed:
                () => _navigateToScreen(
                  const NotificationScreen(),
                  updateSelected: true,
                  indexToSet: 1,
                ),
          ),
          IconButton(
            icon: const Icon(Icons.warning, color: Colors.red, size: 20),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [..._getMenuSections(), const SizedBox(height: 30)],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 24,
                  color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                ),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 24,
                  color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                ),
                onPressed:
                    () => _navigateToScreen(
                      const NotificationScreen(),
                      updateSelected: true,
                      indexToSet: 1,
                    ),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  size: 24,
                  color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
                ),
                onPressed:
                    () => _navigateToScreen(
                      const SettingScreen(),
                      updateSelected: true,
                      indexToSet: 2,
                    ),
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 24,
                  color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
                ),
                onPressed:
                    () => _navigateToScreen(
                      const UserScreen(),
                      updateSelected: true,
                      indexToSet: 3,
                    ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fitur absensi atau lainnya
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.fingerprint, color: Colors.white, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Map<String, dynamic>> items) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      child: Column(
        children: [_buildSectionTitle(title), _buildGridSection(items)],
      ),
    );
  }

  Widget _buildGridSection(List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.9,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildGridItem(items[index]);
      },
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => getScreenByTitle(item['title']),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(item['icon'], color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              item['title'],
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
