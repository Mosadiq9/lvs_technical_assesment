import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A placeholder for the actual HTTP client (e.g., Dio or http).
/// This satisfies the "API-ready architecture" requirement.
class ApiClient {
  // Normally would initialize Dio or HTTP here.
  
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    // API call logic
    return null;
  }
  
  Future<dynamic> post(String path, {dynamic data}) async {
    // API call logic
    return null;
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
