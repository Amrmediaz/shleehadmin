import 'booking_building.dart';
import 'booking_customer.dart';
import 'booking_day.dart';

/// A single booking, as returned by PaidBookingList / NotPaidBookingList
/// (inside `results`) and by BookingDetiles (as the whole `message`).
class Booking {
  final int id;
  final String name;
  final String phone;
  final num cost;
  final int numberOfDays;
  final String? note;
  final bool isActive;
  final DateTime? createdDate;
  // Inferred from the data (not documented in the swagger): 1 seen on
  // PaidBookingList results, 0 seen on an unpaid booking's details. Treat
  // as best-effort until the backend confirms the full enum.
  final int bookingStatus;
  final String insuranceAmount;
  final String paidAmountLabel;
  final List<BookingDay> bookingDays;
  final int buildingId;
  final BookingBuilding? building;
  final int customerId;
  final BookingCustomer? customer;

  const Booking({
    required this.id,
    required this.name,
    required this.phone,
    required this.cost,
    required this.numberOfDays,
    this.note,
    required this.isActive,
    this.createdDate,
    required this.bookingStatus,
    required this.insuranceAmount,
    required this.paidAmountLabel,
    required this.bookingDays,
    required this.buildingId,
    this.building,
    required this.customerId,
    this.customer,
  });

  bool get isPaid => bookingStatus == 1;

  factory Booking.fromJson(Map<String, dynamic> json) {
    final daysJson = json['bookingDays'];
    final days = daysJson is List
        ? daysJson.whereType<Map<String, dynamic>>().map(BookingDay.fromJson).toList()
        : <BookingDay>[];

    final buildingJson = json['building'];
    final customerJson = json['customer'];

    return Booking(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      cost: (json['coast'] as num?) ?? 0,
      numberOfDays: (json['noOFDays'] as num?)?.toInt() ?? 0,
      note: json['note']?.toString(),
      isActive: json['isActive'] == true,
      createdDate: DateTime.tryParse(json['crreatedDate']?.toString() ?? ''),
      bookingStatus: (json['bookingstatus'] as num?)?.toInt() ?? 0,
      insuranceAmount: json['insuranceamount']?.toString() ?? '0',
      paidAmountLabel: json['paidamount']?.toString() ?? '',
      bookingDays: days,
      buildingId: (json['buildingID'] as num?)?.toInt() ?? 0,
      building: buildingJson is Map<String, dynamic> ? BookingBuilding.fromJson(buildingJson) : null,
      customerId: (json['customerId'] as num?)?.toInt() ?? 0,
      customer: customerJson is Map<String, dynamic> ? BookingCustomer.fromJson(customerJson) : null,
    );
  }
}
