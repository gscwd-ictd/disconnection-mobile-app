// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Team _$TeamFromJson(Map<String, dynamic> json) {
  return _Team.fromJson(json);
}

/// @nodoc
mixin _$Team {
  String? get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get teamLeader => throw _privateConstructorUsedError;
  bool? get status => throw _privateConstructorUsedError;
  int? get jobCode => throw _privateConstructorUsedError;
  List<Member>? get disconnectionMember => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamCopyWith<Team> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCopyWith<$Res> {
  factory $TeamCopyWith(Team value, $Res Function(Team) then) =
      _$TeamCopyWithImpl<$Res, Team>;
  @useResult
  $Res call(
      {String? teamId,
      String? teamName,
      String? teamLeader,
      bool? status,
      int? jobCode,
      List<Member>? disconnectionMember});
}

/// @nodoc
class _$TeamCopyWithImpl<$Res, $Val extends Team>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? teamLeader = freezed,
    Object? status = freezed,
    Object? jobCode = freezed,
    Object? disconnectionMember = freezed,
  }) {
    return _then(_value.copyWith(
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamLeader: freezed == teamLeader
          ? _value.teamLeader
          : teamLeader // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      jobCode: freezed == jobCode
          ? _value.jobCode
          : jobCode // ignore: cast_nullable_to_non_nullable
              as int?,
      disconnectionMember: freezed == disconnectionMember
          ? _value.disconnectionMember
          : disconnectionMember // ignore: cast_nullable_to_non_nullable
              as List<Member>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamImplCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$$TeamImplCopyWith(
          _$TeamImpl value, $Res Function(_$TeamImpl) then) =
      __$$TeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? teamId,
      String? teamName,
      String? teamLeader,
      bool? status,
      int? jobCode,
      List<Member>? disconnectionMember});
}

/// @nodoc
class __$$TeamImplCopyWithImpl<$Res>
    extends _$TeamCopyWithImpl<$Res, _$TeamImpl>
    implements _$$TeamImplCopyWith<$Res> {
  __$$TeamImplCopyWithImpl(_$TeamImpl _value, $Res Function(_$TeamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? teamLeader = freezed,
    Object? status = freezed,
    Object? jobCode = freezed,
    Object? disconnectionMember = freezed,
  }) {
    return _then(_$TeamImpl(
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamLeader: freezed == teamLeader
          ? _value.teamLeader
          : teamLeader // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      jobCode: freezed == jobCode
          ? _value.jobCode
          : jobCode // ignore: cast_nullable_to_non_nullable
              as int?,
      disconnectionMember: freezed == disconnectionMember
          ? _value._disconnectionMember
          : disconnectionMember // ignore: cast_nullable_to_non_nullable
              as List<Member>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamImpl implements _Team {
  const _$TeamImpl(
      {required this.teamId,
      required this.teamName,
      required this.teamLeader,
      required this.status,
      required this.jobCode,
      required final List<Member>? disconnectionMember})
      : _disconnectionMember = disconnectionMember;

  factory _$TeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamImplFromJson(json);

  @override
  final String? teamId;
  @override
  final String? teamName;
  @override
  final String? teamLeader;
  @override
  final bool? status;
  @override
  final int? jobCode;
  final List<Member>? _disconnectionMember;
  @override
  List<Member>? get disconnectionMember {
    final value = _disconnectionMember;
    if (value == null) return null;
    if (_disconnectionMember is EqualUnmodifiableListView)
      return _disconnectionMember;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Team(teamId: $teamId, teamName: $teamName, teamLeader: $teamLeader, status: $status, jobCode: $jobCode, disconnectionMember: $disconnectionMember)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamLeader, teamLeader) ||
                other.teamLeader == teamLeader) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.jobCode, jobCode) || other.jobCode == jobCode) &&
            const DeepCollectionEquality()
                .equals(other._disconnectionMember, _disconnectionMember));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      teamId,
      teamName,
      teamLeader,
      status,
      jobCode,
      const DeepCollectionEquality().hash(_disconnectionMember));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      __$$TeamImplCopyWithImpl<_$TeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamImplToJson(
      this,
    );
  }
}

abstract class _Team implements Team {
  const factory _Team(
      {required final String? teamId,
      required final String? teamName,
      required final String? teamLeader,
      required final bool? status,
      required final int? jobCode,
      required final List<Member>? disconnectionMember}) = _$TeamImpl;

  factory _Team.fromJson(Map<String, dynamic> json) = _$TeamImpl.fromJson;

  @override
  String? get teamId;
  @override
  String? get teamName;
  @override
  String? get teamLeader;
  @override
  bool? get status;
  @override
  int? get jobCode;
  @override
  List<Member>? get disconnectionMember;
  @override
  @JsonKey(ignore: true)
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
