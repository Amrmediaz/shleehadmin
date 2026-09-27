import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_exception.dart';
import '../data/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({HomeRepository? homeRepository})
      : _homeRepository = homeRepository ?? HomeRepository(),
        super(const HomeState.loading());

  final HomeRepository _homeRepository;

  Future<void> load() async {
    emit(const HomeState.loading());
    try {
      final stats = await _homeRepository.getHomeStats();
      emit(HomeState.loaded(stats));
    } on ApiException catch (e) {
      emit(HomeState.error(e.message));
    } catch (_) {
      emit(const HomeState.error('Could not reach the server. Check your connection.'));
    }
  }
}
