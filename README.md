# ipr_ff_generator

Кодогенератор для типобезпечного доступу до Firebase Remote Config. Анотуються два
enumʼи — один на фіча-флаги, другий на моделі – а генератор збирає з них єдиний
`RemoteConfigService` з типізованими геттерами та набором інтерфейсів для сегрегації
залежностей.

## Що це робить

Замість того щоб вручну писати обгортки над `getBool` / `getString` і парсити JSON
на кожен ключ Remote Config, ти описуєш ключі декларативно — константами enumʼа:

```dart
@featureFlagEnum
enum FeatureFlag {
  partnerEnabled,
  referralEnabled,
}

@remoteValueEnum
enum RemoteValueKey {
  @RemoteValue<PartnerProgram>('partner_program')
  partnerProgram,

  @RemoteValue<ReferralConditions>('referral_conditions')
  referralConditions,
}
```

## Рантайм-контракт

> **Це поточна незакрита залежність.**

Згенерований `RemoteConfigService` посилається на два імені, яких **немає** в самому
генераторі:

- `RemoteConfigSource` — джерело значень (`bool getBool(String)`, `String getString(String)`);
- `decodeRc<T>(String raw, T Function(Map<String, dynamic>) fromJson)` — делегат
  десеріалізації моделей.

Оскільки згенерований файл — це `part` бібліотеки-споживача, він ділить її
import-скоуп і **не може мати власних імпортів**. Тому обидва імені мусять бути видимі
у файлі, де оголошені анотовані enumʼи.

## Швидкий старт

### 1. Залежності

```yaml
# example/pubspec.yaml
dependencies:
  ipr_ff_generator_annotations:
    path: ../lib/annotations   # або з pub, якщо опублікуєш

dev_dependencies:
  build_runner: ^2.4.13
  ipr_ff_generator:
    path: ../
```

### 2. Моделі з `fromJson`

```dart
// example/lib/models.dart
class PartnerProgram {
  PartnerProgram({required this.id, required this.name});

  factory PartnerProgram.fromJson(Map<String, dynamic> json) =>
      PartnerProgram(id: json['id'] as int, name: json['name'] as String);

  final int id;
  final String name;
}
```

### 3. Анотовані enumʼи + `part`

```dart
// example/lib/config.dart
import 'package:ipr_ff_generator_annotations/ipr_ff_generator_annotations.dart';

import 'models.dart';

part 'config.g.dart';

@featureFlagEnum
enum FeatureFlag {
  partnerEnabled,
  referralEnabled,
}

@remoteValueEnum
enum RemoteValueKey {
  @RemoteValue<PartnerProgram>('partner_program')
  partnerProgram,

  @RemoteValue<ReferralConditions>('referral_conditions')
  referralConditions,
}
```

### 4. Генерація

```bash
cd example
dart pub get
dart run build_runner build --delete-conflicting-outputs
```


### 5. Використання

```dart
final rc = RemoteConfigService(myRemoteConfigSource);
if (rc.partnerEnabled) {
  final program = rc.partnerProgram; // вже десеріалізована модель
}
```

## Довідник анотацій

| Анотація | Ціль | Призначення |
|---|---|---|
| `@featureFlagEnum` | enum | Позначає enum як джерело фіча-флагів. Кожна константа → `bool`-геттер. |
| `@remoteValueEnum` | enum | Позначає enum як джерело моделей. Кожна константа потребує `@RemoteValue`. |
| `@RemoteValue<T>('key')` | enum-константа | `T` — тип моделі (має `fromJson`), `'key'` — ключ у Remote Config. |
