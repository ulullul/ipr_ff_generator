import '../getters_builders/getter_builder.dart';

class ModelsGenerationValue {
  static String generationValue(Iterable<Getters> getters) =>
      '''
abstract interface class IRemoteConfigModels {

  ${getters.map((e) => e.abstractGetter).join('\n')}

}
''';
}
