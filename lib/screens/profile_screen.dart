import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String fullName;

  ProfileScreen({required this.username, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menggeser tulisan "Welcome" ke atas
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Welcome, $fullName',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 40), // Menambahkan jarak antara Welcome dan input

            // Menambahkan input disabled untuk username dan fullname
            TextField(
              controller: TextEditingController(text: username),
              decoration: InputDecoration(
                labelText: 'Username',
              ),
              readOnly: true, // Menonaktifkan input
            ),
            SizedBox(height: 20),
            TextField(
              controller: TextEditingController(text: fullName),
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
              readOnly: true, // Menonaktifkan input
            ),
            SizedBox(height: 40),

            // Tombol Logout
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/',
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
