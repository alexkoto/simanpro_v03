import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simanpro_v03/screens/auth/login.dart';
import 'package:simanpro_v03/services/local_storage.dart';
import 'package:simanpro_v03/services/api_users.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Map<String, dynamic> _userData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await LocalStorage.getUserData();
    setState(() {
      _userData = data;
      _isLoading = false;
    });
  }

  

  Future<void> _logout() async {
    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Konfirmasi Logout'),
            content: const Text('Apakah Anda yakin ingin keluar?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );

    if (confirmed != true || !mounted) return;

    final scaffold = ScaffoldMessenger.of(context);
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final result = await ApiUser.logout();

      // Close loading dialog
      if (mounted) Navigator.pop(context);

      if (!mounted) return;

      if (result['success'] == true) {
        // Navigate to LoginScreen and remove all routes
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        scaffold.showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Gagal logout')),
        );
      }
    } catch (e, stackTrace) {
      print('Logout error: $e');
      print('Stack trace: $stackTrace');

      // Close loading dialog if still mounted
      if (mounted) Navigator.pop(context);

      if (!mounted) return;

      scaffold.showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan saat logout')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final userInfo = {
      'Nama': _userData['name'] ?? 'Tidak tersedia',
      'Email': _userData['email'] ?? 'Tidak tersedia',
      // 'Jabatan': _getRoleName(_userData['role_id'] ?? '6'),
      'Jabatan': _getRoleName(_userData['role_id']?.toString() ?? '6'),

      'ID Pengguna': _userData['id']?.toString() ?? 'Tidak tersedia',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blueAccent,
            
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              userInfo['Nama']!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children:
                    userInfo.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            entry.value,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Divider(height: 20),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur edit belum tersedia')),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profil'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _getRoleName(String roleId) {
    switch (roleId) {
      case '1':
        return 'Admin';
      case '2':
        return 'Finance';
      case '3':
        return 'Logistik';
      case '4':
        return 'Project Manager';
      case '5':
        return 'Supervisor';
      case '6':
        return 'Karyawan';
      default:
        return 'Teknisi';
    }
  }
}
