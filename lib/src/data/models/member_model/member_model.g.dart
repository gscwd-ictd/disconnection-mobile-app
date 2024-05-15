// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
      memberId: json['memberId'] as String?,
      companyId: json['companyId'] as String?,
      memberName: json['memberName'] as String?,
      disconnectorCode: (json['disconnectorCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'companyId': instance.companyId,
      'memberName': instance.memberName,
      'disconnectorCode': instance.disconnectorCode,
    };
