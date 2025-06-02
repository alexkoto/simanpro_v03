import 'package:flutter/material.dart';
import 'package:simanpro_v03/constants.dart';
import 'package:simanpro_v03/screens/auth/login.dart';
import 'package:simanpro_v03/services/api_connection.dart';
import 'package:simanpro_v03/services/api_users.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalette.primaryColor,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            _icon(),
            _titleDescription(),
            Form(key: _formKey, child: _textFields()),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Image.asset("assets/images/logoPAL2.png", width: 80.0, height: 80.0);
  }

  Widget _titleDescription() {
    return Column(
      children: <Widget>[
        SizedBox(height: 16.0),
        Text(
          "REGISTRASI",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          "Silakan isi data untuk membuat akun baru.",
          style: TextStyle(color: Colors.white70, fontSize: 14.0),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _textFields() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField,
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            hintText: "Nama Lengkap",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.white),
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Nama tidak boleh kosong'
                      : null,
        ),
        SizedBox(height: 12.0),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField,
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            hintText: "Email",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.white),
          validator:
              (value) =>
                  value == null || value.isEmpty
                      ? 'Email tidak boleh kosong'
                      : null,
        ),
        SizedBox(height: 12.0),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField,
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            hintText: "Password",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.white),
          validator:
              (value) =>
                  value == null || value.length < 6
                      ? 'Password minimal 6 karakter'
                      : null,
        ),
        SizedBox(height: 12.0),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField,
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            hintText: "Konfirmasi Password",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.white),
          validator:
              (value) =>
                  value != _passwordController.text
                      ? 'Password tidak cocok'
                      : null,
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              final response = await ApiUser.registerUser(
                _nameController.text,
                _emailController.text,
                _passwordController.text,
              );

              if (response != null) {
                if (response['success']) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registrasi berhasil!')),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Registrasi gagal: ${response['message']}'),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Registrasi gagal. Tidak ada respon dari server.',
                    ),
                  ),
                );
              }
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              'Registrasi',
              style: TextStyle(
                color: ColorPalette.primaryColor,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text('Sudah punya akun?', style: TextStyle(color: Colors.white)),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
          child: Text(
            'Login Sekarang',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
