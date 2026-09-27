import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import 'home_stats.dart';

class HomeRepository {
  HomeRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<HomeStats> getHomeStats() async {
    final message = await _apiClient.getEnvelope(ApiEndpoints.homePage);
    return HomeStats.fromJson(message);
  }
}
