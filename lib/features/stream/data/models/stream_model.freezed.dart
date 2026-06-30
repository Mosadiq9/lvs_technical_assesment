// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stream_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StreamModel {

 String get id; String get streamerName; String get streamerAvatarUrl; String get thumbnailUrl; int get viewerCount; String get countryCode; String get categoryId; bool get isFollowed;
/// Create a copy of StreamModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreamModelCopyWith<StreamModel> get copyWith => _$StreamModelCopyWithImpl<StreamModel>(this as StreamModel, _$identity);

  /// Serializes this StreamModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreamModel&&(identical(other.id, id) || other.id == id)&&(identical(other.streamerName, streamerName) || other.streamerName == streamerName)&&(identical(other.streamerAvatarUrl, streamerAvatarUrl) || other.streamerAvatarUrl == streamerAvatarUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.viewerCount, viewerCount) || other.viewerCount == viewerCount)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,streamerName,streamerAvatarUrl,thumbnailUrl,viewerCount,countryCode,categoryId,isFollowed);

@override
String toString() {
  return 'StreamModel(id: $id, streamerName: $streamerName, streamerAvatarUrl: $streamerAvatarUrl, thumbnailUrl: $thumbnailUrl, viewerCount: $viewerCount, countryCode: $countryCode, categoryId: $categoryId, isFollowed: $isFollowed)';
}


}

/// @nodoc
abstract mixin class $StreamModelCopyWith<$Res>  {
  factory $StreamModelCopyWith(StreamModel value, $Res Function(StreamModel) _then) = _$StreamModelCopyWithImpl;
@useResult
$Res call({
 String id, String streamerName, String streamerAvatarUrl, String thumbnailUrl, int viewerCount, String countryCode, String categoryId, bool isFollowed
});




}
/// @nodoc
class _$StreamModelCopyWithImpl<$Res>
    implements $StreamModelCopyWith<$Res> {
  _$StreamModelCopyWithImpl(this._self, this._then);

  final StreamModel _self;
  final $Res Function(StreamModel) _then;

/// Create a copy of StreamModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? streamerName = null,Object? streamerAvatarUrl = null,Object? thumbnailUrl = null,Object? viewerCount = null,Object? countryCode = null,Object? categoryId = null,Object? isFollowed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,streamerName: null == streamerName ? _self.streamerName : streamerName // ignore: cast_nullable_to_non_nullable
as String,streamerAvatarUrl: null == streamerAvatarUrl ? _self.streamerAvatarUrl : streamerAvatarUrl // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,viewerCount: null == viewerCount ? _self.viewerCount : viewerCount // ignore: cast_nullable_to_non_nullable
as int,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StreamModel].
extension StreamModelPatterns on StreamModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StreamModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StreamModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StreamModel value)  $default,){
final _that = this;
switch (_that) {
case _StreamModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StreamModel value)?  $default,){
final _that = this;
switch (_that) {
case _StreamModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String streamerName,  String streamerAvatarUrl,  String thumbnailUrl,  int viewerCount,  String countryCode,  String categoryId,  bool isFollowed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StreamModel() when $default != null:
return $default(_that.id,_that.streamerName,_that.streamerAvatarUrl,_that.thumbnailUrl,_that.viewerCount,_that.countryCode,_that.categoryId,_that.isFollowed);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String streamerName,  String streamerAvatarUrl,  String thumbnailUrl,  int viewerCount,  String countryCode,  String categoryId,  bool isFollowed)  $default,) {final _that = this;
switch (_that) {
case _StreamModel():
return $default(_that.id,_that.streamerName,_that.streamerAvatarUrl,_that.thumbnailUrl,_that.viewerCount,_that.countryCode,_that.categoryId,_that.isFollowed);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String streamerName,  String streamerAvatarUrl,  String thumbnailUrl,  int viewerCount,  String countryCode,  String categoryId,  bool isFollowed)?  $default,) {final _that = this;
switch (_that) {
case _StreamModel() when $default != null:
return $default(_that.id,_that.streamerName,_that.streamerAvatarUrl,_that.thumbnailUrl,_that.viewerCount,_that.countryCode,_that.categoryId,_that.isFollowed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StreamModel extends StreamModel {
  const _StreamModel({required this.id, required this.streamerName, required this.streamerAvatarUrl, required this.thumbnailUrl, required this.viewerCount, required this.countryCode, required this.categoryId, this.isFollowed = false}): super._();
  factory _StreamModel.fromJson(Map<String, dynamic> json) => _$StreamModelFromJson(json);

@override final  String id;
@override final  String streamerName;
@override final  String streamerAvatarUrl;
@override final  String thumbnailUrl;
@override final  int viewerCount;
@override final  String countryCode;
@override final  String categoryId;
@override@JsonKey() final  bool isFollowed;

/// Create a copy of StreamModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreamModelCopyWith<_StreamModel> get copyWith => __$StreamModelCopyWithImpl<_StreamModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StreamModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreamModel&&(identical(other.id, id) || other.id == id)&&(identical(other.streamerName, streamerName) || other.streamerName == streamerName)&&(identical(other.streamerAvatarUrl, streamerAvatarUrl) || other.streamerAvatarUrl == streamerAvatarUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.viewerCount, viewerCount) || other.viewerCount == viewerCount)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,streamerName,streamerAvatarUrl,thumbnailUrl,viewerCount,countryCode,categoryId,isFollowed);

@override
String toString() {
  return 'StreamModel(id: $id, streamerName: $streamerName, streamerAvatarUrl: $streamerAvatarUrl, thumbnailUrl: $thumbnailUrl, viewerCount: $viewerCount, countryCode: $countryCode, categoryId: $categoryId, isFollowed: $isFollowed)';
}


}

/// @nodoc
abstract mixin class _$StreamModelCopyWith<$Res> implements $StreamModelCopyWith<$Res> {
  factory _$StreamModelCopyWith(_StreamModel value, $Res Function(_StreamModel) _then) = __$StreamModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String streamerName, String streamerAvatarUrl, String thumbnailUrl, int viewerCount, String countryCode, String categoryId, bool isFollowed
});




}
/// @nodoc
class __$StreamModelCopyWithImpl<$Res>
    implements _$StreamModelCopyWith<$Res> {
  __$StreamModelCopyWithImpl(this._self, this._then);

  final _StreamModel _self;
  final $Res Function(_StreamModel) _then;

/// Create a copy of StreamModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? streamerName = null,Object? streamerAvatarUrl = null,Object? thumbnailUrl = null,Object? viewerCount = null,Object? countryCode = null,Object? categoryId = null,Object? isFollowed = null,}) {
  return _then(_StreamModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,streamerName: null == streamerName ? _self.streamerName : streamerName // ignore: cast_nullable_to_non_nullable
as String,streamerAvatarUrl: null == streamerAvatarUrl ? _self.streamerAvatarUrl : streamerAvatarUrl // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,viewerCount: null == viewerCount ? _self.viewerCount : viewerCount // ignore: cast_nullable_to_non_nullable
as int,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
