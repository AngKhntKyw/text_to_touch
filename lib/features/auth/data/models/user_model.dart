import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String user_id,
    required String name,
    required String email,
    required String fcm_token,
    required bool is_online,
    required DateTime last_online,
    required bool in_chat,
    required String profile_url,
    required String cover_url,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
