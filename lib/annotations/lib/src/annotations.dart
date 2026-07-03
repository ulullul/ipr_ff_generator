/// Маркери ролі enuma (вішаються на сам enum).
class FeatureFlagEnum {
  const FeatureFlagEnum();
}

const featureFlagEnum = FeatureFlagEnum();

class RemoteValueEnum {
  const RemoteValueEnum();
}

const remoteValueEnum = RemoteValueEnum();

/// Анотація на КОЖНУ константу value-enuma.
/// `key` — ключ у Remote Config. `T` — тип моделі, у яку парситься значення.
/// T живе в самому типі анотації (typeArguments), а не в її полях.
class RemoteValue<T> {
  const RemoteValue(this.key);
  final String key;
}