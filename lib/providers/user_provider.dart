import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _businessName = 'Mewing Laundry';
  double _revenue = 15000000; // Pendapatan dummy
  double _sales = 12000000; // Penjualan dummy
  double _expense = 3000000; // Pengeluaran dummy
  double _grossRevenue = 18000000; // Pendapatan kotor dummy

  String get businessName => _businessName;
  double get revenue => _revenue;
  double get sales => _sales;
  double get expense => _expense;
  double get grossRevenue => _grossRevenue;

  // Fungsi format rupiah (opsional, tapi berguna)
  String formatRupiah(double value) {
    final formatter = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return 'Rp. ${value.toStringAsFixed(0).replaceAllMapped(formatter, (m) => '.')}';
  }
}
