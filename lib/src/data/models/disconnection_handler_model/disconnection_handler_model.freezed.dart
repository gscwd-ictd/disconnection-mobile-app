// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'disconnection_handler_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DisconnectionHandler _$DisconnectionHandlerFromJson(Map<String, dynamic> json) {
  return _DisconnectionHandler.fromJson(json);
}

/// @nodoc
mixin _$DisconnectionHandler {
  List<ConsumerModel>? get items => throw _privateConstructorUsedError;
  List<LibZones>? get zoneList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DisconnectionHandlerCopyWith<DisconnectionHandler> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DisconnectionHandlerCopyWith<$Res> {
  factory $DisconnectionHandlerCopyWith(DisconnectionHandler value,
          $Res Function(DisconnectionHandler) then) =
      _$DisconnectionHandlerCopyWithImpl<$Res, DisconnectionHandler>;
  @useResult
  $Res call({List<ConsumerModel>? items, List<LibZones>? zoneList});
}

/// @nodoc
class _$DisconnectionHandlerCopyWithImpl<$Res,
        $Val extends DisconnectionHandler>
    implements $DisconnectionHandlerCopyWith<$Res> {
  _$DisconnectionHandlerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? zoneList = freezed,
  }) {
    return _then(_value.copyWith(
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ConsumerModel>?,
      zoneList: freezed == zoneList
          ? _value.zoneList
          : zoneList // ignore: cast_nullable_to_non_nullable
              as List<LibZones>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DisconnectionHandlerImplCopyWith<$Res>
    implements $DisconnectionHandlerCopyWith<$Res> {
  factory _$$DisconnectionHandlerImplCopyWith(_$DisconnectionHandlerImpl value,
          $Res Function(_$DisconnectionHandlerImpl) then) =
      __$$DisconnectionHandlerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ConsumerModel>? items, List<LibZones>? zoneList});
}

/// @nodoc
class __$$DisconnectionHandlerImplCopyWithImpl<$Res>
    extends _$DisconnectionHandlerCopyWithImpl<$Res, _$DisconnectionHandlerImpl>
    implements _$$DisconnectionHandlerImplCopyWith<$Res> {
  __$$DisconnectionHandlerImplCopyWithImpl(_$DisconnectionHandlerImpl _value,
      $Res Function(_$DisconnectionHandlerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? zoneList = freezed,
  }) {
    return _then(_$DisconnectionHandlerImpl(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ConsumerModel>?,
      zoneList: freezed == zoneList
          ? _value._zoneList
          : zoneList // ignore: cast_nullable_to_non_nullable
              as List<LibZones>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DisconnectionHandlerImpl implements _DisconnectionHandler {
  const _$DisconnectionHandlerImpl(
      {required final List<ConsumerModel>? items,
      required final List<LibZones>? zoneList})
      : _items = items,
        _zoneList = zoneList;

  factory _$DisconnectionHandlerImpl.fromJson(Map<String, dynamic> json) =>
      _$$DisconnectionHandlerImplFromJson(json);

  final List<ConsumerModel>? _items;
  @override
  List<ConsumerModel>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<LibZones>? _zoneList;
  @override
  List<LibZones>? get zoneList {
    final value = _zoneList;
    if (value == null) return null;
    if (_zoneList is EqualUnmodifiableListView) return _zoneList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DisconnectionHandler(items: $items, zoneList: $zoneList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisconnectionHandlerImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other._zoneList, _zoneList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_zoneList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DisconnectionHandlerImplCopyWith<_$DisconnectionHandlerImpl>
      get copyWith =>
          __$$DisconnectionHandlerImplCopyWithImpl<_$DisconnectionHandlerImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DisconnectionHandlerImplToJson(
      this,
    );
  }
}

abstract class _DisconnectionHandler implements DisconnectionHandler {
  const factory _DisconnectionHandler(
      {required final List<ConsumerModel>? items,
      required final List<LibZones>? zoneList}) = _$DisconnectionHandlerImpl;

  factory _DisconnectionHandler.fromJson(Map<String, dynamic> json) =
      _$DisconnectionHandlerImpl.fromJson;

  @override
  List<ConsumerModel>? get items;
  @override
  List<LibZones>? get zoneList;
  @override
  @JsonKey(ignore: true)
  _$$DisconnectionHandlerImplCopyWith<_$DisconnectionHandlerImpl>
      get copyWith => throw _privateConstructorUsedError;
}
