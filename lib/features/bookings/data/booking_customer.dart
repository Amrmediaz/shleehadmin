class BookingCustomer {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  const BookingCustomer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  String get fullName => [firstName, lastName].where((s) => s.trim().isNotEmpty).join(' ').trim();

  factory BookingCustomer.fromJson(Map<String, dynamic> json) {
    return BookingCustomer(
      id: (json['id'] as num?)?.toInt() ?? 0,
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
    );
  }
}
