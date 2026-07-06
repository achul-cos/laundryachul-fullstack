import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/customer_model.dart';

class CustomerProvider extends ChangeNotifier {
  final List<Customer> _customers = [
    // Data dummy awal
    Customer(
      id: '1',
      name: 'Budi Santoso',
      phone: '081234567890',
      address: 'Jl. Merdeka No. 10, Jakarta',
      email: 'budi@email.com',
      createdAt: DateTime.now().subtract(Duration(days: 5)),
    ),
    Customer(
      id: '2',
      name: 'Siti Nurhaliza',
      phone: '082345678901',
      address: 'Jl. Ahmad Yani No. 25, Bandung',
      email: 'siti@email.com',
      createdAt: DateTime.now().subtract(Duration(days: 3)),
    ),
    Customer(
      id: '3',
      name: 'Ahmad Suryanto',
      phone: '083456789012',
      address: 'Jl. Gatot Subroto No. 5, Surabaya',
      email: 'ahmad@email.com',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  String _searchQuery = '';
  String _filterStatus = 'Semua'; // Filter dummy

  List<Customer> get customers {
    List<Customer> filtered = _customers;

    // Filter berdasarkan search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    return filtered;
  }

  String get searchQuery => _searchQuery;
  String get filterStatus => _filterStatus;

  // Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Set filter
  void setFilterStatus(String status) {
    _filterStatus = status;
    notifyListeners();
  }

  // Add customer
  void addCustomer(String name, String phone, String address, String email) {
    final newCustomer = Customer(
      id: Uuid().v4(),
      name: name,
      phone: phone,
      address: address,
      email: email,
      createdAt: DateTime.now(),
    );
    _customers.add(newCustomer);
    notifyListeners();
  }

  // Update customer
  void updateCustomer(
    String id,
    String name,
    String phone,
    String address,
    String email,
  ) {
    final index = _customers.indexWhere((c) => c.id == id);
    if (index != -1) {
      _customers[index] = _customers[index].copyWith(
        name: name,
        phone: phone,
        address: address,
        email: email,
      );
      notifyListeners();
    }
  }

  // Delete customer
  void deleteCustomer(String id) {
    _customers.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  // Get single customer
  Customer? getCustomerById(String id) {
    try {
      return _customers.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }
}
