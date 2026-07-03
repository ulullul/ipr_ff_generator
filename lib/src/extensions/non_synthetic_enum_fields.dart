import 'package:analyzer/dart/element/element.dart';

extension NonSyntheticEnumFields on EnumElement {
  Iterable<FieldElement> get nonSyntheticEnumFields => fields.where((f) => f.isEnumConstant);
}
