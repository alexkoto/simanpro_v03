import 'package:flutter/material.dart';
import 'package:simanpro_v03/constants.dart';
import 'package:simanpro_v03/screens/auth/register.dart';
import 'package:simanpro_v03/screens/home/home_screen.dart';
import 'package:simanpro_v03/services/api_users.dart';
import 'package:simanpro_v03/services/local_storage.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    final authData = await LocalStorage.getAuthData();
    if (authData['rememberMe'] == true && authData['token'] != null) {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final response = await ApiUser.loginUser(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        print('Full login response: $response');

        if (response['status'] == 1) {
          // Check your API's success condition
          // Save user data if remember me is checked
          if (_rememberMe) {
            await LocalStorage.saveAuthData(
              response['token'] ??
                  'dummy_token', // Use actual token if available
              _emailController.text.trim(),
              _rememberMe,
            );
            // Save additional user data if needed
            await LocalStorage.saveUserData(response['user'] ?? {});
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'] ?? 'Login berhasil')),
          );
          _navigateToHome();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'] ?? 'Login gagal')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalette.primaryColor,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            _iconLogin(),
            _titleDescription(),
            Form(key: _formKey, child: _textFields()),
            _rememberMeCheckbox(),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _iconLogin() {
    return Image.asset("assets/images/logoPAL2.png", height: 80.0, width: 80.0);
  }

  Widget _rememberMeCheckbox() {
    return Row(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor:
                Colors.white, // Warna ketika tidak tercentang
          ),
          child: Checkbox(
            value: _rememberMe,
            onChanged: (value) => setState(() => _rememberMe = value ?? false),
            checkColor: Colors.blue, // Warna centang
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white; // Warna background ketika tercentang
              }
              return Colors
                  .transparent; // Warna background ketika tidak tercentang
            }),
          ),
        ),
        const SizedBox(width: 8),
        Text('Ingat Saya', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _titleDescription() {
    return Column(
      children: <Widget>[
        SizedBox(height: 16.0),
        Text(
          "LOGIN SIMANPRO",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          "Selamat datang, silakan login untuk melanjutkan.",
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
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        _isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : InkWell(
              onTap: _login, // Call the _login method
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        SizedBox(height: 16.0),
        Text('Belum punya akun?', style: TextStyle(color: Colors.white)),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => RegisterScreen()),
            );
          },
          child: Text(
            'Daftar Sekarang',
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
}
