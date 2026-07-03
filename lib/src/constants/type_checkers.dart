import 'package:ipr_ff_generator_annotations/ipr_ff_generator_annotations.dart';
import 'package:source_gen/source_gen.dart';

class TypeCheckers {
  static const flagEnum = TypeChecker.typeNamed(FeatureFlagEnum);
  static const valueEnum = TypeChecker.typeNamed(RemoteValueEnum);
  static const valueAnnotation = TypeChecker.typeNamed(RemoteValue);
}