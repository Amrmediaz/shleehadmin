/// Response payload of GET /AppOwner/HomePage.
class HomeStats {
  final int customers;
  final int buildings;
  final int hotelBuildings;
  final int buildingOwners;
  final int bookingCount;
  final int hotelBookingCount;
  final num amount;
  final num hotelAmount;

  const HomeStats({
    required this.customers,
    required this.buildings,
    required this.hotelBuildings,
    required this.buildingOwners,
    required this.bookingCount,
    required this.hotelBookingCount,
    required this.amount,
    required this.hotelAmount,
  });

  factory HomeStats.fromJson(Map<String, dynamic> json) {
    int asInt(dynamic v) => (v as num?)?.toInt() ?? 0;
    num asNum(dynamic v) => (v as num?) ?? 0;
    return HomeStats(
      customers: asInt(json['customer']),
      buildings: asInt(json['buliding']),
      hotelBuildings: asInt(json['hotelbuliding']),
      buildingOwners: asInt(json['bulidingowner']),
      bookingCount: asInt(json['bookingcount']),
      hotelBookingCount: asInt(json['hotelbookingcount']),
      amount: asNum(json['amount']),
      hotelAmount: asNum(json['hotelamount']),
    );
  }

  static const empty = HomeStats(
    customers: 0,
    buildings: 0,
    hotelBuildings: 0,
    buildingOwners: 0,
    bookingCount: 0,
    hotelBookingCount: 0,
    amount: 0,
    hotelAmount: 0,
  );
}
