import '../getters_builders/getter_builder.dart';

class FeatureFlagsGenerationValue {
  static String generationValue(Iterable<Getters> getters) =>
      '''
abstract interface class IRemoteConfigFeatureFlags {
  
  ${getters.map((e) => e.abstractGetter).join('\n')}

}
''';
}
