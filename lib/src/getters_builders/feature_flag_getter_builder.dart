import 'package:analyzer/dart/element/element.dart';
import 'package:change_case/change_case.dart';
import 'package:ipr_ff_generator/src/extensions/non_synthetic_enum_fields.dart';
import 'package:ipr_ff_generator/src/getters_builders/getter_builder.dart';

class FeatureFlagGetterBuilder implements GetterBuilder {
  @override
  final EnumElement enumElement;

  const FeatureFlagGetterBuilder({required this.enumElement});

  @override
  Iterable<Getters> build() {
    final fields = enumElement.nonSyntheticEnumFields;
    fields.any((e) {
      if (e.name == null) throw Exception('$e should have a name');
      return true;
    });

    return fields.map((c) {
      final key = c.name!.toSnakeCase();
      return (
        implementationGetter: "  bool get ${c.name} => _rc.getBool('$key');",
        abstractGetter: "  bool get ${c.name};",
      );
    });
  }
}
