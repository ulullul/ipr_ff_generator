class PartnerProgram {
  PartnerProgram({required this.id, required this.name});

  factory PartnerProgram.fromJson(Map<String, dynamic> json) => PartnerProgram(
    id: json['id'] as int,
    name: json['name'] as String,
  );

  final int id;
  final String name;
}

class ReferralConditions {
  ReferralConditions({required this.minInvites, required this.bonus});

  factory ReferralConditions.fromJson(Map<String, dynamic> json) =>
      ReferralConditions(
        minInvites: json['min_invites'] as int,
        bonus: (json['bonus'] as num).toDouble(),
      );

  final int minInvites;
  final double bonus;
}