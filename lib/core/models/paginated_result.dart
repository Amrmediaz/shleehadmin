/// Generic wrapper for the `{results, currentPage, pageCount, pageSize,
/// rowCount}` shape returned by PaymentList / PaidBookingList /
/// NotPaidBookingList.
class PaginatedResult<T> {
  final List<T> results;
  final int currentPage;
  final int pageCount;
  final int pageSize;
  final int rowCount;

  const PaginatedResult({
    required this.results,
    required this.currentPage,
    required this.pageCount,
    required this.pageSize,
    required this.rowCount,
  });

  factory PaginatedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final rawList = json['results'];
    final list = rawList is List
        ? rawList
            .whereType<Map<String, dynamic>>()
            .map(fromJson)
            .toList(growable: false)
        : <T>[];
    return PaginatedResult<T>(
      results: list,
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
      pageCount: (json['pageCount'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? list.length,
      rowCount: (json['rowCount'] as num?)?.toInt() ?? list.length,
    );
  }

  bool get hasNextPage => currentPage < pageCount;
  bool get hasPreviousPage => currentPage > 1;

  static PaginatedResult<T> empty<T>() => PaginatedResult<T>(
        results: const [],
        currentPage: 1,
        pageCount: 1,
        pageSize: 0,
        rowCount: 0,
      );
}
