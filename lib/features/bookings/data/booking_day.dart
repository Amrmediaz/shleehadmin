class BookingDay {
  final String day;
  final bool isFullDay;

  const BookingDay({required this.day, required this.isFullDay});

  factory BookingDay.fromJson(Map<String, dynamic> json) {
    return BookingDay(
      day: json['day']?.toString() ?? '',
      isFullDay: json['isFullDay'] == true,
    );
  }
}
