/// Chalet/building details embedded in a booking.
///
/// Note: several numeric-looking fields (rent, capacity, bedrooms…) come
/// back from the API as strings, so they're kept as `String?` here and
/// only parsed to numbers where the UI needs to do math with them.
class BookingBuilding {
  final int id;
  final String name;
  final String chaletType;
  final String state;
  final String gouvernate;
  final String? rentFullday;
  final String? rentHalfday;
  final String? capacity;
  final String? bedrooms;
  final String? bathrooms;
  final String? description;
  final String? note;
  final bool isActive;

  const BookingBuilding({
    required this.id,
    required this.name,
    required this.chaletType,
    required this.state,
    required this.gouvernate,
    this.rentFullday,
    this.rentHalfday,
    this.capacity,
    this.bedrooms,
    this.bathrooms,
    this.description,
    this.note,
    required this.isActive,
  });

  factory BookingBuilding.fromJson(Map<String, dynamic> json) {
    return BookingBuilding(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      chaletType: json['chaletType']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      gouvernate: json['gouvernate']?.toString() ?? '',
      rentFullday: json['rentFullday']?.toString(),
      rentHalfday: json['rentHalfday']?.toString(),
      capacity: json['capacity']?.toString(),
      bedrooms: json['bedrooms']?.toString(),
      bathrooms: json['bathrooms']?.toString(),
      description: json['buldingDescrption']?.toString(),
      note: json['note']?.toString(),
      isActive: json['isActive'] == true,
    );
  }

  String get location => [state, gouvernate].where((s) => s.trim().isNotEmpty).join(', ');
}
