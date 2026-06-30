class Environment {
  Environment._();

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.aliveapp.com/v1',
  );

  static const bool isProduction = bool.fromEnvironment(
    'IS_PRODUCTION',
    defaultValue: false,
  );
}
