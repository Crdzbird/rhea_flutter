enum Environment { development, staging, production }

class DartDefine {
  static const env = String.fromEnvironment('env', defaultValue: 'development');
  static const rheaUrl = String.fromEnvironment('rheaUrl');
  static const _networkTimeout = String.fromEnvironment('networkTimeout');
  static int get networkTimeout => int.tryParse(_networkTimeout) ?? 60;

  static Environment environment() {
    switch (env.toUpperCase()) {
      case 'development':
        return Environment.development;
      case 'staging':
        return Environment.staging;
      case 'production':
        return Environment.production;
      default:
        return Environment.development;
    }
  }
}
