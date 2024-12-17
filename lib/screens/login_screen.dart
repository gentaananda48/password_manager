import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../encryption_helper.dart';
import 'profile_screen.dart';
import 'register_screen.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      print("Please fill in both fields.");
      return;
    }

    User? userProfile = await _dbHelper.getUserProfile(username);
    if (userProfile == null) {
      print("User not found.");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User not found')));
    } else {
      String decryptedPassword =
          EncryptionHelper.decryptPassword(userProfile.password, username);

      if (decryptedPassword == password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(username: username)),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Incorrect password')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Don\'t have an account? Register'),
            )
          ],
        ),
      ),
    );
  }
}
