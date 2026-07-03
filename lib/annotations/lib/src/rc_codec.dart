import 'dart:convert';

/// Абстракція над джерелом RC. У тестовому проекті імплементуєш in-memory,
/// у проді — просто міняєш тип на FirebaseRemoteConfig (сигнатури getBool/
/// getString збігаються, тому згенерований код не чіпаєш).
abstract interface class RemoteConfigSource {
  bool getBool(String key);
  String getString(String key);
}

/// Рантайм-делегат декодування. Саме сюди винесено `dart:convert`, щоб
/// згенерований part НЕ тягнув dart:-залежності у свій import-скоуп.
T decodeRc<T>(String raw, T Function(Map<String, dynamic>) fromJson) =>
    fromJson(jsonDecode(raw) as Map<String, dynamic>);