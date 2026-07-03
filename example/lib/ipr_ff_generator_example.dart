import 'models.dart';
import 'package:ipr_ff_generator_annotations/ipr_ff_generator_annotations.dart';
import 'rc_codec.dart';

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
