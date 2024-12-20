import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class EncryptionHelper {
  // Fungsi untuk mengenkripsi password
  static String encryptPassword(String password, String key) {
    try {
      // Panjang kunci 16 karakter
      final keyBytes = key.padRight(16, ' ').substring(0, 16).codeUnits;
      final iv = encrypt.IV.fromLength(16); // IV yang panjangnya 16 byte

      // Inisialisasi enkripter dengan mode CBC
      final encrypter = encrypt.Encrypter(
        encrypt.AES(encrypt.Key.fromUtf8(String.fromCharCodes(keyBytes)),
            mode: encrypt.AESMode.cbc),
      );

      // Enkripsi password
      final encrypted = encrypter.encrypt(password, iv: iv);

      // Gabungkan IV dan password terenkripsi, dan encode dalam base64
      final ivBase64 = base64.encode(iv.bytes);
      final encryptedPasswordBase64 = encrypted.base64;

      // Gabungkan IV dan password terenkripsi
      return '$ivBase64:$encryptedPasswordBase64';
    } catch (e) {
      print('Error during encryption: $e');
      return '';
    }
  }

  // Fungsi untuk mendekripsi password
  static String decryptPassword(String encryptedData, String key) {
    try {
      // Pisahkan IV dan data terenkripsi
      final parts = encryptedData.split(':');
      final ivBase64 = parts[0];
      final encryptedPasswordBase64 = parts[1];

      // Ambil IV dari base64
      final iv = encrypt.IV.fromBase64(ivBase64);

      // Panjang kunci 16 karakter
      final keyBytes = key.padRight(16, ' ').substring(0, 16).codeUnits;

      // Inisialisasi enkripter dengan mode CBC
      final encrypter = encrypt.Encrypter(
        encrypt.AES(encrypt.Key.fromUtf8(String.fromCharCodes(keyBytes)),
            mode: encrypt.AESMode.cbc),
      );

      // Dekripsi password
      final decrypted = encrypter.decrypt64(encryptedPasswordBase64, iv: iv);
      return decrypted; // Mengembalikan hasil dekripsi
    } catch (e) {
      print('Error during decryption: $e');
      return '';
    }
  }

  // Fungsi untuk memverifikasi password
  static bool verifyPassword(
      String password, String encryptedData, String key) {
    return password == decryptPassword(encryptedData, key);
  }
}
