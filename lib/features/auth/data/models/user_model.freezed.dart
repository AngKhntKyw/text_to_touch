// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get user_id; String get name; String get email; String get fcm_token; bool get is_online; DateTime get last_online; bool get in_chat; String get profile_url; String get cover_url;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.user_id, user_id) || other.user_id == user_id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.fcm_token, fcm_token) || other.fcm_token == fcm_token)&&(identical(other.is_online, is_online) || other.is_online == is_online)&&(identical(other.last_online, last_online) || other.last_online == last_online)&&(identical(other.in_chat, in_chat) || other.in_chat == in_chat)&&(identical(other.profile_url, profile_url) || other.profile_url == profile_url)&&(identical(other.cover_url, cover_url) || other.cover_url == cover_url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user_id,name,email,fcm_token,is_online,last_online,in_chat,profile_url,cover_url);

@override
String toString() {
  return 'UserModel(user_id: $user_id, name: $name, email: $email, fcm_token: $fcm_token, is_online: $is_online, last_online: $last_online, in_chat: $in_chat, profile_url: $profile_url, cover_url: $cover_url)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String user_id, String name, String email, String fcm_token, bool is_online, DateTime last_online, bool in_chat, String profile_url, String cover_url
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user_id = null,Object? name = null,Object? email = null,Object? fcm_token = null,Object? is_online = null,Object? last_online = null,Object? in_chat = null,Object? profile_url = null,Object? cover_url = null,}) {
  return _then(_self.copyWith(
user_id: null == user_id ? _self.user_id : user_id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fcm_token: null == fcm_token ? _self.fcm_token : fcm_token // ignore: cast_nullable_to_non_nullable
as String,is_online: null == is_online ? _self.is_online : is_online // ignore: cast_nullable_to_non_nullable
as bool,last_online: null == last_online ? _self.last_online : last_online // ignore: cast_nullable_to_non_nullable
as DateTime,in_chat: null == in_chat ? _self.in_chat : in_chat // ignore: cast_nullable_to_non_nullable
as bool,profile_url: null == profile_url ? _self.profile_url : profile_url // ignore: cast_nullable_to_non_nullable
as String,cover_url: null == cover_url ? _self.cover_url : cover_url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String user_id,  String name,  String email,  String fcm_token,  bool is_online,  DateTime last_online,  bool in_chat,  String profile_url,  String cover_url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.user_id,_that.name,_that.email,_that.fcm_token,_that.is_online,_that.last_online,_that.in_chat,_that.profile_url,_that.cover_url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String user_id,  String name,  String email,  String fcm_token,  bool is_online,  DateTime last_online,  bool in_chat,  String profile_url,  String cover_url)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.user_id,_that.name,_that.email,_that.fcm_token,_that.is_online,_that.last_online,_that.in_chat,_that.profile_url,_that.cover_url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String user_id,  String name,  String email,  String fcm_token,  bool is_online,  DateTime last_online,  bool in_chat,  String profile_url,  String cover_url)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.user_id,_that.name,_that.email,_that.fcm_token,_that.is_online,_that.last_online,_that.in_chat,_that.profile_url,_that.cover_url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.user_id, required this.name, required this.email, required this.fcm_token, required this.is_online, required this.last_online, required this.in_chat, required this.profile_url, required this.cover_url});
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String user_id;
@override final  String name;
@override final  String email;
@override final  String fcm_token;
@override final  bool is_online;
@override final  DateTime last_online;
@override final  bool in_chat;
@override final  String profile_url;
@override final  String cover_url;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.user_id, user_id) || other.user_id == user_id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.fcm_token, fcm_token) || other.fcm_token == fcm_token)&&(identical(other.is_online, is_online) || other.is_online == is_online)&&(identical(other.last_online, last_online) || other.last_online == last_online)&&(identical(other.in_chat, in_chat) || other.in_chat == in_chat)&&(identical(other.profile_url, profile_url) || other.profile_url == profile_url)&&(identical(other.cover_url, cover_url) || other.cover_url == cover_url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user_id,name,email,fcm_token,is_online,last_online,in_chat,profile_url,cover_url);

@override
String toString() {
  return 'UserModel(user_id: $user_id, name: $name, email: $email, fcm_token: $fcm_token, is_online: $is_online, last_online: $last_online, in_chat: $in_chat, profile_url: $profile_url, cover_url: $cover_url)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String user_id, String name, String email, String fcm_token, bool is_online, DateTime last_online, bool in_chat, String profile_url, String cover_url
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user_id = null,Object? name = null,Object? email = null,Object? fcm_token = null,Object? is_online = null,Object? last_online = null,Object? in_chat = null,Object? profile_url = null,Object? cover_url = null,}) {
  return _then(_UserModel(
user_id: null == user_id ? _self.user_id : user_id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fcm_token: null == fcm_token ? _self.fcm_token : fcm_token // ignore: cast_nullable_to_non_nullable
as String,is_online: null == is_online ? _self.is_online : is_online // ignore: cast_nullable_to_non_nullable
as bool,last_online: null == last_online ? _self.last_online : last_online // ignore: cast_nullable_to_non_nullable
as DateTime,in_chat: null == in_chat ? _self.in_chat : in_chat // ignore: cast_nullable_to_non_nullable
as bool,profile_url: null == profile_url ? _self.profile_url : profile_url // ignore: cast_nullable_to_non_nullable
as String,cover_url: null == cover_url ? _self.cover_url : cover_url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
