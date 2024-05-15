// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remarks_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Remarks _$RemarksFromJson(Map<String, dynamic> json) {
  return _Remarks.fromJson(json);
}

/// @nodoc
mixin _$Remarks {
  String? get id => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool? get isRemarks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RemarksCopyWith<Remarks> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemarksCopyWith<$Res> {
  factory $RemarksCopyWith(Remarks value, $Res Function(Remarks) then) =
      _$RemarksCopyWithImpl<$Res, Remarks>;
  @useResult
  $Res call({String? id, String? description, bool? isRemarks});
}

/// @nodoc
class _$RemarksCopyWithImpl<$Res, $Val extends Remarks>
    implements $RemarksCopyWith<$Res> {
  _$RemarksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? description = freezed,
    Object? isRemarks = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isRemarks: freezed == isRemarks
          ? _value.isRemarks
          : isRemarks // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RemarksImplCopyWith<$Res> implements $RemarksCopyWith<$Res> {
  factory _$$RemarksImplCopyWith(
          _$RemarksImpl value, $Res Function(_$RemarksImpl) then) =
      __$$RemarksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? description, bool? isRemarks});
}

/// @nodoc
class __$$RemarksImplCopyWithImpl<$Res>
    extends _$RemarksCopyWithImpl<$Res, _$RemarksImpl>
    implements _$$RemarksImplCopyWith<$Res> {
  __$$RemarksImplCopyWithImpl(
      _$RemarksImpl _value, $Res Function(_$RemarksImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? description = freezed,
    Object? isRemarks = freezed,
  }) {
    return _then(_$RemarksImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isRemarks: freezed == isRemarks
          ? _value.isRemarks
          : isRemarks // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemarksImpl implements _Remarks {
  const _$RemarksImpl(
      {required this.id, required this.description, required this.isRemarks});

  factory _$RemarksImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemarksImplFromJson(json);

  @override
  final String? id;
  @override
  final String? description;
  @override
  final bool? isRemarks;

  @override
  String toString() {
    return 'Remarks(id: $id, description: $description, isRemarks: $isRemarks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemarksImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isRemarks, isRemarks) ||
                other.isRemarks == isRemarks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, description, isRemarks);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemarksImplCopyWith<_$RemarksImpl> get copyWith =>
      __$$RemarksImplCopyWithImpl<_$RemarksImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemarksImplToJson(
      this,
    );
  }
}

abstract class _Remarks implements Remarks {
  const factory _Remarks(
      {required final String? id,
      required final String? description,
      required final bool? isRemarks}) = _$RemarksImpl;

  factory _Remarks.fromJson(Map<String, dynamic> json) = _$RemarksImpl.fromJson;

  @override
  String? get id;
  @override
  String? get description;
  @override
  bool? get isRemarks;
  @override
  @JsonKey(ignore: true)
  _$$RemarksImplCopyWith<_$RemarksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
