import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@CopyWith()
class UserModel {
  final String id;
  final String name;
  final String bio;

  UserModel({
    required this.id,
    required this.name,
    required this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  List<Object?> get props => [id, name, bio];
}
