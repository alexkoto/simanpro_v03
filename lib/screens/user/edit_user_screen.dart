import 'package:flutter/material.dart';
import 'package:simanpro_v03/services/api_users.dart';

class EditUserScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  EditUserScreen({required this.user});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  TextEditingController passwordController = TextEditingController();
  String? roleId;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user['name']);
    emailController = TextEditingController(text: widget.user['email']);
    roleId = widget.user['role_id']?.toString();
  }

  void updateUser() async {
    if (_formKey.currentState!.validate()) {
      final result = await ApiUser.updateUser(
        widget.user['id'],
        nameController.text,
        emailController.text,
        password: passwordController.text,
        roleId: roleId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Gagal update')),
      );

      if (result['success']) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit User')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Email wajib diisi' : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password (opsional)'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateUser,
                child: Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
