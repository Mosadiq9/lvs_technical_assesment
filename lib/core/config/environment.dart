import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  Environment._();

  static String get apiBaseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'https://api.aliveapp.com/v1';
  }

  static String get googleServerClientId {
    return dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? '502805992034-3psevtncu2avi1e36dr0u3dqubkrou9g.apps.googleusercontent.com';
  }

  static bool get isProduction {
    final val = dotenv.env['IS_PRODUCTION']?.toLowerCase();
    return val == 'true' || val == '1';
  }
}
