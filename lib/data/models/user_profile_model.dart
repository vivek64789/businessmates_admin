import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';


@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required String uid,
    @JsonKey(name: 'image_url') required String imageUrl,
    required String role,
    required String email,
    required String name,
    required String phone,
    required String address,
    required String city,
    required String state,
    required String country,
    @JsonKey(name: "created_at") required DateTime createdAt,
    @JsonKey(name: "updated_at") required DateTime updatedAt,
  }) = _UserProfileModel;

  const UserProfileModel._();

  factory UserProfileModel.empty() => UserProfileModel(
        uid: '',
        role: '',
        email: '',
        name: '',
        phone: '',
        address: '',
        city: '',
        state: '',
        country: '',
        imageUrl: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
}
