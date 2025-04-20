enum Flavor { qa, production }

final class Environment {
  static late Flavor flavor;

  static String get baseUrl {
    switch (flavor) {
      case Flavor.qa:
        return 'https://api-flutter-prova-qa.hml.sesisenai.org.br/';
      case Flavor.production:
        return 'https://api-flutter-prova.hml.sesisenai.org.br/';
    }
  }

  static bool get isProduction => flavor == Flavor.production;
}
