import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/paginated_result.dart';
import '../../../core/network/api_exception.dart';
import '../data/booking.dart';
import 'booking_list_state.dart';

/// Generic paginated booking list cubit. Reused for both the "Paid" and
/// "Not Paid" tabs — each screen just passes in the matching repository
/// method as [fetchPage].
class BookingListCubit extends Cubit<BookingListState> {
  BookingListCubit({required this.fetchPage}) : super(BookingListState.loading()) {
    loadPage(1);
  }

  final Future<PaginatedResult<Booking>> Function({required int page}) fetchPage;

  Future<void> loadPage(int page) async {
    emit(BookingListState.loading());
    try {
      final result = await fetchPage(page: page);
      emit(BookingListState.loaded(result));
    } on ApiException catch (e) {
      emit(BookingListState.error(e.message));
    } catch (_) {
      emit(BookingListState.error('Could not reach the server. Check your connection.'));
    }
  }

  Future<void> refresh() => loadPage(state.page.currentPage == 0 ? 1 : state.page.currentPage);

  Future<void> nextPage() {
    if (!state.page.hasNextPage) return Future.value();
    return loadPage(state.page.currentPage + 1);
  }

  Future<void> previousPage() {
    if (!state.page.hasPreviousPage) return Future.value();
    return loadPage(state.page.currentPage - 1);
  }
}
