import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import 'account_screen.dart';
import 'customer_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC8102E),
        elevation: 0,
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _selectedIndex == 0
          ? _buildDashboardContent()
          : _buildOtherContent(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Pelanggan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFC8102E),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildDashboardContent() {
    final userProvider = context.watch<UserProvider>();
    final user = context.watch<AuthProvider>().user;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header merah
          Container(
            color: Color(0xFFC8102E),
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(height: 16),
                Text(
                  '${userProvider.businessName}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // 4 Kartu Statistik
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildStatCard(
                  'Pendapatan Bersih',
                  userProvider.formatRupiah(userProvider.revenue),
                  Colors.green[100]!,
                  Icons.money,
                  Colors.green,
                ),
                _buildStatCard(
                  'Penjualan',
                  userProvider.formatRupiah(userProvider.sales),
                  Colors.amber[100]!,
                  Icons.shopping_bag,
                  Colors.amber,
                ),
                _buildStatCard(
                  'Pengeluaran',
                  userProvider.formatRupiah(userProvider.expense),
                  Colors.blue[100]!,
                  Icons.trending_down,
                  Colors.blue,
                ),
                _buildStatCard(
                  'Pendapatan Kotor',
                  userProvider.formatRupiah(userProvider.grossRevenue),
                  Colors.pink[100]!,
                  Icons.receipt,
                  Colors.pink,
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Grid Menu
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildMenuIcon(Icons.shopping_cart, 'Pesanan', () {}),
                    _buildMenuIcon(
                      Icons.local_laundry_service,
                      'Layanan',
                      () {},
                    ),
                    _buildMenuIcon(Icons.people, 'Pelanggan', () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    }),
                    _buildMenuIcon(Icons.person_3, 'Karyawan', () {}),
                    _buildMenuIcon(Icons.history, 'History', () {}),
                    _buildMenuIcon(Icons.add_card, 'Top Up', () {}),
                    _buildMenuIcon(Icons.bar_chart, 'Laporan', () {}),
                    _buildMenuIcon(Icons.more_horiz, 'Lihat Semua', () {}),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildOtherContent() {
    if (_selectedIndex == 1) {
      return CustomerListScreen();
    } else if (_selectedIndex == 2) {
      return AccountScreen();
    }
    return SizedBox.expand(child: Center(child: Text('Coming Soon')));
  }

  Widget _buildStatCard(
    String title,
    String value,
    Color bgColor,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: iconColor, size: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: Colors.grey[700]),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
