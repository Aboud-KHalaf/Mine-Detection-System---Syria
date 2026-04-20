import 'package:json_annotation/json_annotation.dart';

part 'user_token_model.g.dart';

@JsonSerializable()
class UserTokenModel {
  final String token;

  UserTokenModel({required this.token});

  factory UserTokenModel.fromJson(Map<String, dynamic> json) => _$UserTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserTokenModelToJson(this);
}
