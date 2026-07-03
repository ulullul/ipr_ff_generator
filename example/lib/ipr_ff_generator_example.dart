import 'models.dart';
import 'package:ipr_ff_generator_annotations/ipr_ff_generator_annotations.dart';

part 'ipr_ff_generator_example.g.dart';

@featureFlagEnum
enum FeatureFlag { partnerEnabled, referralEnabled }

@remoteValueEnum
enum RemoteValueKey {
  @RemoteValue<PartnerProgram>('partner_program')
  partnerProgram,
  @RemoteValue<ReferralConditions>('referral_conditions')
  referralConditions,
}

class RemoteConfig implements RemoteConfigSource {
  @override
  bool getBool(String key) {
    print('get bool');
    return true;
  }

  @override
  String getString(String key) {
    print('getString');
    return '';
  }

}

void main() {
  final rc = RemoteConfig();
  final service = RemoteConfigService(rc);

  print(service.partnerProgram);
}
