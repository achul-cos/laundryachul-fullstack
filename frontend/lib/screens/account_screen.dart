import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC8102E),
        elevation: 0,
        title: Text(
          'Akun Saya',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profile
            Container(
              color: Color(0xFFC8102E),
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFFC8102E),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    user?.name ?? 'User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      user?.role ?? 'User',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user?.email ?? 'email@example.com',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Menu Items
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildMenuTile(
                    context,
                    Icons.person_outline,
                    'Profil Saya',
                    'Lihat dan edit profil',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fitur sedang dikembangkan')),
                      );
                    },
                  ),
                  Divider(height: 0),
                  _buildMenuTile(
                    context,
                    Icons.lock_outline,
                    'Ganti Password',
                    'Ubah password akun',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fitur sedang dikembangkan')),
                      );
                    },
                  ),
                  Divider(height: 0),
                  _buildMenuTile(
                    context,
                    Icons.info_outline,
                    'Tentang Aplikasi',
                    'Versi dan informasi',
                    () {
                      _showAboutDialog(context);
                    },
                  ),
                  Divider(height: 0),
                  _buildMenuTile(
                    context,
                    Icons.privacy_tip_outlined,
                    'Kebijakan Privasi',
                    'Baca kebijakan privasi kami',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fitur sedang dikembangkan')),
                      );
                    },
                  ),
                  Divider(height: 0),
                  _buildMenuTile(
                    context,
                    Icons.mail_outline,
                    'Hubungi Kami',
                    'Email: support@mewing-laundry.com',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fitur sedang dikembangkan')),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Logout Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Keluar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 32),

            // App Info Footer
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Mewing Laundry v1.0.0',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '#pakeMEWINGaja',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFFC8102E)),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Keluar?'),
        content: Text('Yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
            child: Text('Keluar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tentang Aplikasi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mewing Laundry',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('Versi: 1.0.0'),
            SizedBox(height: 4),
            Text('Aplikasi manajemen laundry modern'),
            SizedBox(height: 12),
            Text(
              'Dikembangkan dengan Flutter',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
