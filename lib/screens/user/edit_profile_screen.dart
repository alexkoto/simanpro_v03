import 'package:flutter/material.dart';
import 'package:simanpro_v03/services/api_users.dart';
import 'package:simanpro_v03/services/local_storage.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData['name']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _phoneController = TextEditingController(
      text: widget.userData['phone'] ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfilePicture(),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              enabled: false, // Email biasanya tidak bisa diubah
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Nomor HP'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                widget.userData['profile_picture'] != null
                    ? NetworkImage(widget.userData['profile_picture'])
                        as ImageProvider
                    : const AssetImage('assets/images/default_profile.png'),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: _changeProfilePicture,
            ),
          ),
        ],
      ),
    );
  }

  void _changeProfilePicture() {
    // Implementasi upload gambar
  }

void _saveProfile() async {
  final updatedName = _nameController.text;
  final updatedPhone = _phoneController.text;
  final userId = widget.userData['id'].toString();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  final result = await ApiUser.updateUserProfile(
    id: userId,
    name: updatedName,
    phone: updatedPhone,
  );

  if (mounted) Navigator.pop(context); // Close dialog

  if (result['success'] == true) {
    final updatedData = {
      ...widget.userData,
      'name': updatedName,
      'phone': updatedPhone,
    };

    await LocalStorage.saveUserData(updatedData);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui')),
      );
      Navigator.pop(context, true);
    }
  } else {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Gagal memperbarui profil')),
      );
    }
  }
}

}
