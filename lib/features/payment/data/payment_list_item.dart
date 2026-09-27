/// A single row from GET /AppOwner/PaymentList.
class PaymentListItem {
  final int id;
  final int orderId;
  final String trackId;
  final num cost;
  final int refId;
  final String phone;
  final String name;
  final int customerId;
  final int type;
  final int paymentType;
  final DateTime? createdDate;

  const PaymentListItem({
    required this.id,
    required this.orderId,
    required this.trackId,
    required this.cost,
    required this.refId,
    required this.phone,
    required this.name,
    required this.customerId,
    required this.type,
    required this.paymentType,
    this.createdDate,
  });

  factory PaymentListItem.fromJson(Map<String, dynamic> json) {
    return PaymentListItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      orderId: (json['orderId'] as num?)?.toInt() ?? 0,
      trackId: json['trackid']?.toString() ?? '',
      cost: (json['coast'] as num?) ?? 0,
      refId: (json['refId'] as num?)?.toInt() ?? 0,
      phone: json['phone']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      customerId: (json['customerId'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      paymentType: (json['paymenttype'] as num?)?.toInt() ?? 0,
      createdDate: DateTime.tryParse(json['createdDate']?.toString() ?? ''),
    );
  }
}
