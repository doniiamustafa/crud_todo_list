
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "data")
  final Map<String, dynamic> data;

  const LoginResponse({required this.message, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}