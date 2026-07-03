import '../getters_builders/getter_builder.dart';

class RemoteConfigServiceGenerationValue {
  static String generationValue({
    Iterable<Getters>? featureFlagsGetters,
    Iterable<Getters>? modelsGetters,
  }) {
    final hasFeatureFlags = featureFlagsGetters != null, hasModels = modelsGetters != null;

    if (!hasFeatureFlags && !hasModels) return '';

    return '''
abstract interface class IRemoteConfigService implements ${hasFeatureFlags ? 'IRemoteConfigFeatureFlags' : ''} ${hasFeatureFlags && hasModels ? ',  ' : ''} ${hasModels ? 'IRemoteConfigModels' : ''} {}

class RemoteConfigService implements IRemoteConfigService {
  const RemoteConfigService(this._rc);
  final RemoteConfigSource _rc;

  ${hasFeatureFlags ? featureFlagsGetters.map((e) => '@override\n${e.implementationGetter}').join('\n') : ''}
  ${hasModels ? modelsGetters.map((e) => '@override\n${e.implementationGetter}').join('\n') : ''}
}''';
  }
}
