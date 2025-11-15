import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TomatCheck/controller/controller.dart';
import 'scan_page.dart';
import 'detail_page.dart';
import 'profil_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF4EA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER
            Stack(
              children: [
                Image.asset(
                  'assets/tomat_bg.JPEG',
                  width: double.infinity,
                  height: 210,
                  fit: BoxFit.cover,
                ),
                // Lapisan hijau transparan
                Container(
                  width: double.infinity,
                  height: 210,
                  color: const Color(0xAA9ACF53),
                ),
                // Teks header
                Positioned(
                  left: 20,
                  bottom: 25,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Analisis Cepat & Akurat",
                        style: TextStyle(
                          color: Color(0xFFD3E36A),
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Teknologi AI terdepan untuk\nmendeteksi kesegaran tomat\ndengan akurasi tinggi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          height: 1.4,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // KARTU RIWAYAT
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: predictionProvider.predictionHistory.isEmpty
                    ? const [
                        Text(
                          'Belum ada hasil analisis',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontFamily: 'Arial',
                          ),
                        ),
                      ]
                    : predictionProvider.predictionHistory.map((item) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 18,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: 0.1,
                                ), // ganti from withOpacity
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status Tomat : ${item['status']}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Arial',
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Menampilkan Akurasi prediksi
                              Text(
                                "Prediksi Akurasi : ${item['acc'] ?? 'Tidak tersedia'}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Arial',
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 6),

                              Text(
                                "Dianalisis Pada : ${item['tanggal']}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Arial',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),

      // NAVBAR
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightGreen,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == _selectedIndex) return;

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ScanPage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DetailPage()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfilPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "Scan",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: "Tentang",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
