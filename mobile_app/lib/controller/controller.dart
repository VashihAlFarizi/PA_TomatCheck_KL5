import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PredictionProvider with ChangeNotifier {
  File? imageFile;
  String? predictionMessage;
  final ImagePicker _picker = ImagePicker();

  // Riwayat hasil prediksi
  final List<Map<String, String>> _predictionHistory = [];
  List<Map<String, String>> get predictionHistory => _predictionHistory;

  // Ambil gambar dari kamera
  Future<void> pickImageCamera(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      predictionMessage = null; // reset hasil sebelumnya
      notifyListeners();
    }
  }

  // Ambil gambar dari galeri
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      predictionMessage = null; // reset hasil sebelumnya
      notifyListeners();
    }
  }

  // Kirim gambar ke API untuk mendapatkan prediksi
  Future<void> predictImage() async {
    if (imageFile == null) return;

    final url = Uri.parse(
      'http://127.0.0.1:8000/api/predict-image',
    ); // Ganti sesuai backend
    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('image', imageFile!.path));

    try {
      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseData);

        // Cek struktur respons
        if (data['prediction'] != null && data['prediction'] is Map) {
          predictionMessage = data['prediction']['predicted_class'];
        } else if (data['predicted_class'] != null) {
          predictionMessage = data['predicted_class'];
        } else {
          predictionMessage = 'Gagal membaca hasil prediksi';
        }

        // Simpan ke riwayat
        _predictionHistory.add({
          'status': data['prediction']['predicted_class'],
          'acc': data['prediction']['confidence'].toString() + '%',
          'tanggal': DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
        });
      } else {
        predictionMessage = 'Error ${response.statusCode}: $responseData';
      }
    } catch (e) {
      predictionMessage = 'Terjadi kesalahan: $e';
    }

    notifyListeners();
  }

  // Reset gambar dan hasil prediksi
  void clear() {
    imageFile = null;
    predictionMessage = null;
    notifyListeners();
  }
}
