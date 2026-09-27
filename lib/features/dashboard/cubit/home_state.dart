import 'package:equatable/equatable.dart';

import '../data/home_stats.dart';

enum HomeStatus { loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final HomeStats stats;
  final String? errorMessage;

  const HomeState._({required this.status, required this.stats, this.errorMessage});

  const HomeState.loading() : this._(status: HomeStatus.loading, stats: HomeStats.empty);

  const HomeState.loaded(HomeStats stats) : this._(status: HomeStatus.loaded, stats: stats);

  const HomeState.error(String message)
      : this._(status: HomeStatus.error, stats: HomeStats.empty, errorMessage: message);

  @override
  List<Object?> get props => [status, stats.customers, stats.bookingCount, errorMessage];
}
