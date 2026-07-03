import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:ipr_ff_generator/src/extensions/non_synthetic_enum_fields.dart';
import 'package:ipr_ff_generator/src/getters_builders/getter_builder.dart';
import 'package:source_gen/source_gen.dart';

import '../constants/type_checkers.dart';

class ModelsGetterBuilder implements GetterBuilder {
  @override
  final EnumElement enumElement;

  const ModelsGetterBuilder({required this.enumElement});

  @override
  Iterable<Getters> build() => enumElement.nonSyntheticEnumFields.map(_buildModelGetter);

  Getters _buildModelGetter(FieldElement constant) {
    final ann = TypeCheckers.valueAnnotation.firstAnnotationOf(constant);
    if (ann == null) {
      throw InvalidGenerationSourceError(
        'Константа ${constant.name} мусить мати @RemoteValue<T>(...).',
        element: constant,
      );
    }

    final key = ConstantReader(ann).read('key').stringValue;

    // T витягуємо з типу самої анотації: RemoteValue<Model> -> Model.
    final annType = ann.type! as InterfaceType;
    final modelType = annType.typeArguments.first; // DartType, не рантайм Type
    // analyzer 6.x ВИМАГАЄ withNullability. На новіших — без аргументів.
    final modelName = modelType.getDisplayString();

    _assertHasFromJson(modelType, modelName, constant);

    return (
      implementationGetter:
          "  $modelName get ${constant.name} => decodeRc(_rc.getString('$key'), $modelName.fromJson);",
      abstractGetter: "  $modelName get ${constant.name};",
    );
  }

  /// Перевіряємо наявність fromJson на ЕЛЕМЕНТІ моделі ще під час білда,
  /// щоб юзер отримав нормальну помилку з вказівкою на рядок, а не
  /// невиразний компайл-фейл у згенерованому файлі.
  void _assertHasFromJson(DartType modelType, String modelName, FieldElement constant) {
    // [Element2] тут: (modelType as InterfaceType).element3
    final el = (modelType as InterfaceType).element;
    if (el is! ClassElement) {
      throw InvalidGenerationSourceError(
        '$modelName має бути класом із fromJson.',
        element: constant,
      );
    }
    // [Element2] тут: el.constructors2
    final hasFromJson = el.constructors.any((c) => c.name == 'fromJson');
    if (!hasFromJson) {
      throw InvalidGenerationSourceError(
        'Модель $modelName мусить мати конструктор fromJson.',
        element: constant,
        todo: 'Додай factory $modelName.fromJson(Map<String, dynamic> json)',
      );
    }
  }
}
