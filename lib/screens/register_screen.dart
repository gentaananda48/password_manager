import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../encryption_helper.dart';
import 'login_screen.dart';
import '../models/user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  void _register() async {
    String username = _usernameController.text;
    String fullName = _fullNameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || fullName.isEmpty || password.isEmpty) {
      print("Please fill in all fields.");
      return;
    }

    String encryptedPassword =
        EncryptionHelper.encryptPassword(password, username);

    User user = User(
      username: username,
      fullName: fullName,
      password: encryptedPassword,
    );

    await _dbHelper.insertUserProfile(user);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Registration successful')));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
