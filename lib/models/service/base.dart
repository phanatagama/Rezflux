abstract class BaseService {
  final String mediaBaseUrl = "https://restaurant-api.dicoding.dev";

  Future<dynamic> getResponse(String url);

}