import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_in_page.dart';
import 'scan_page.dart'; // Asumsi Anda punya file ini
import 'home_page.dart'; // Asumsi Anda punya file ini
import 'detail_page.dart'; // Asumsi Anda punya file ini

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  int _selectedIndex = 3;

  String username = "Loading...";
  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // username & email dari SharedPreferences
  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('user_name') ?? "User";
      email = prefs.getString('user_email') ?? "email@example.com";
    });
  }

  // ==========================================================
  // !! BAGIAN INI YANG DIUBAH !!
  // ==========================================================
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    
    // JANGAN GUNAKAN prefs.clear()
    // await prefs.clear(); 
    
    // HANYA HAPUS status login 'remember_me'
    // Ini akan membuat pengguna harus login lagi nanti,
    // TAPI data akunnya (email/pass) masih ada.
    await prefs.remove('remember_me');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SignInPage()),
      (route) => false,
    );
  }
  // ==========================================================
  // !! AKHIR DARI PERUBAHAN !!
  // ==========================================================


  // Edit Profil
  void _showEditProfileDialog() {
    final TextEditingController usernameController =
        TextEditingController(text: username);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Edit Profil",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 15),
                const Icon(Icons.account_circle,
                    size: 100, color: Color(0xFF9CCC65)),
                const SizedBox(height: 20),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF9CCC65)),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                        'user_name', usernameController.text);

                    setState(() {
                      username = usernameController.text;
                    });

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9CCC65),
                  ),
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5ED),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _showEditProfileDialog,
                        child: const Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Color(0xFF9CCC65),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        email,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _logout, // <-- Memanggil fungsi _logout yg sdh benar
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.lightGreen,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          if (index == _selectedIndex) return;

          if (index == 0) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const ScanPage()));
          } else if (index == 1) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomePage()));
          } else if (index == 2) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const DetailPage()));
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'Tentang'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}