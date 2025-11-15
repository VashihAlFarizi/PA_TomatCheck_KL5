import 'package:flutter/material.dart';
import 'sign_in_page.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil ukuran layar
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F5ED),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: screenHeight * 0.04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 🔺 Gambar utama
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: Image.asset(
                    'assets/intro3.png',
                    height: screenHeight * 0.35,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // 🔹 Teks utama
                const Text(
                  'Jaga Kualitas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: screenHeight * 0.02),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Yuk mulai sekarang dan lihat betapa mudahnya mendeteksi tomat segar!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // 🔘 Indikator halaman
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.circle, size: 8, color: Colors.black26),
                    SizedBox(width: 4),
                    Icon(Icons.circle, size: 8, color: Colors.black26),
                    SizedBox(width: 4),
                    Icon(Icons.circle, size: 8, color: Colors.black45),
                  ],
                ),

                SizedBox(height: screenHeight * 0.05),

                // 🔳 Tombol mulai
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD1E25C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.22,
                      vertical: screenHeight * 0.02,
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Mulai Aplikasi",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.08), // jarak aman bawah
              ],
            ),
          ),
        ),
      ),
    );
  }
}
