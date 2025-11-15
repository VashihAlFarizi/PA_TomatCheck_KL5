import 'package:flutter/material.dart';
import 'intro3_page.dart';
import 'sign_in_page.dart'; // ✅ tambahkan ini

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
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
                // 🖼️ Gambar
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: Image.asset(
                    'assets/intro2.png',
                    height: screenHeight * 0.35,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // 📝 Judul dan teks
                const Text(
                  'Cukup Foto Tomat',
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
                    'Ambil gambar tomatmu, dan biarkan sistem bekerja '
                        'menilai kesegaran tomat dengan cepat dan mudah!',
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
                    Icon(Icons.circle, size: 8, color: Colors.black45),
                    SizedBox(width: 4),
                    Icon(Icons.circle, size: 8, color: Colors.black26),
                  ],
                ),

                SizedBox(height: screenHeight * 0.04),

                // 🔘 Tombol navigasi bawah
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol "Lewati" ke SignInPage
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Lewati",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // Tombol "Lanjut" ke Page3
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD1E25C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.12,
                          vertical: screenHeight * 0.018,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Page3(),
                          ),
                        );
                      },
                      child: const Text(
                        "Lanjut",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
