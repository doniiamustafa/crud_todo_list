
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "body")
  final Map<String, dynamic> body;

  const LoginResponse({required this.message, required this.body});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}