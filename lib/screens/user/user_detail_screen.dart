import 'package:flutter/material.dart';
import 'package:simanpro_v03/models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  String _getRoleName(String? roleId) {
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
        return 'Tenaga Teknik';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengguna')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${user.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              'Jabatan: ${_getRoleName(user.roleId)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${user.isActive == '1' ? 'Aktif' : 'Nonaktif'}',
              style: const TextStyle(fontSize: 16),
            ),
            // Tambahkan field lainnya jika tersedia
          ],
        ),
      ),
    );
  }
}
