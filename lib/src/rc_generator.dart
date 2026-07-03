import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:ipr_ff_generator/src/constants/models_generation_value.dart';
import 'package:ipr_ff_generator/src/constants/remote_config_service_generation_value.dart';
import 'package:ipr_ff_generator/src/constants/type_checkers.dart';
import 'package:ipr_ff_generator/src/getters_builders/feature_flag_getter_builder.dart';
import 'package:ipr_ff_generator/src/getters_builders/models_getter_builder.dart';
import 'package:source_gen/source_gen.dart';

import 'constants/feature_flags_generation_value.dart';

typedef Getters = ({String abstractGetter, String implementationGetter});

/// Базовий Generator (НЕ GeneratorForAnnotation): за один виклик бачимо
/// обидва enumи в бібліотеці й самі контролюємо порядок виводу трьох класів.
class RemoteConfigGenerator extends Generator {
  const RemoteConfigGenerator();

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final flagEnum = library
        .annotatedWith(TypeCheckers.flagEnum)
        .map((a) => a.element)
        .whereType<EnumElement>()
        .firstOrNull;

    final valueEnum = library
        .annotatedWith(TypeCheckers.valueEnum)
        .map((a) => a.element)
        .whereType<EnumElement>()
        .firstOrNull;

    if (flagEnum == null && valueEnum == null) return '';

    final out = StringBuffer();
    final featureFlagsGetters = switch (flagEnum) {
      null => null,
      _ => FeatureFlagGetterBuilder(enumElement: flagEnum).build(),
    };
    final modelsGetters = switch (valueEnum) {
      null => null,
      _ => ModelsGetterBuilder(enumElement: valueEnum).build(),
    };
    if (featureFlagsGetters != null) {
      out.writeln(FeatureFlagsGenerationValue.generationValue(featureFlagsGetters));
    }

    if (modelsGetters != null) {
      out.writeln(ModelsGenerationValue.generationValue(modelsGetters));
    }

    out.writeln(
      RemoteConfigServiceGenerationValue.generationValue(
        featureFlagsGetters: featureFlagsGetters,
        modelsGetters: modelsGetters,
      ),
    );
    return out.toString();
  }
}
