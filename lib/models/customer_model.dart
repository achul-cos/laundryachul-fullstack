class Customer {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String email;
  final DateTime createdAt;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.createdAt,
  });

  // Untuk update, return copy dengan field yang di-modify
  Customer copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? email,
    DateTime? createdAt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
