// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipr_ff_generator_example.dart';

// **************************************************************************
// RemoteConfigGenerator
// **************************************************************************

abstract interface class IRemoteConfigModels {
  PartnerProgram get partnerProgram;
  ReferralConditions get referralConditions;
}

abstract interface class IRemoteConfigService implements IRemoteConfigModels {}

class RemoteConfigService implements IRemoteConfigService {
  const RemoteConfigService(this._rc);
  final RemoteConfigSource _rc;

  @override
  PartnerProgram get partnerProgram =>
      decodeRc(_rc.getString('partner_program'), PartnerProgram.fromJson);
  @override
  ReferralConditions get referralConditions => decodeRc(
    _rc.getString('referral_conditions'),
    ReferralConditions.fromJson,
  );
}
