import 'package:flutter/material.dart';
import '../encryption_helper.dart';

class EncryptionGeneratorScreen extends StatefulWidget {
  final String username;

  EncryptionGeneratorScreen({required this.username});

  @override
  _EncryptionGeneratorScreenState createState() =>
      _EncryptionGeneratorScreenState();
}

class _EncryptionGeneratorScreenState extends State<EncryptionGeneratorScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();
  bool _isEncrypt = true;
  String _result = '';

  void _processText() {
    String inputText = _inputController.text;
    String key = widget.username;

    if (inputText.isEmpty) {
      print("Please enter some text.");
      return;
    }

    setState(() {
      if (_isEncrypt) {
        _result = EncryptionHelper.encryptPassword(inputText, key);
      } else {
        _result = EncryptionHelper.decryptPassword(inputText, key);
      }
      _resultController.text = _result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Encrypt/Decrypt')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text(_isEncrypt ? 'Encrypt' : 'Decrypt'),
              value: _isEncrypt,
              onChanged: (bool value) {
                setState(() {
                  _isEncrypt = value;
                });
              },
            ),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(labelText: 'Input Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _processText,
              child: Text(_isEncrypt ? 'Encrypt' : 'Decrypt'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _resultController,
              decoration: InputDecoration(labelText: 'Result'),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
