import 'package:flutter/material.dart';
import 'package:simanpro_v03/models/user_model.dart';
import 'package:simanpro_v03/screens/user/user_detail_screen.dart';
import 'package:simanpro_v03/services/api_users.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  Future<List<UserModel>> _fetchUsers() async {
    final data = await ApiUser.getAllUsers();
    print("Raw user data: $data");

    try {
      final users = data.map((json) => UserModel.fromJson(json)).toList();
      print("Parsed user models: $users");
      return users;
    } catch (e) {
      print("Parsing error: $e");
      return [];
    }
  }

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
      appBar: AppBar(title: const Text('Daftar Pengguna')),
      body: FutureBuilder<List<UserModel>>(
        future: _fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data pengguna.'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(user.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.email),
                    Text('Jabatan: ${_getRoleName(user.roleId)}'),
                  ],
                ),
                trailing:
                    user.isActive == '1'
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.cancel, color: Colors.red),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailScreen(user: user),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
