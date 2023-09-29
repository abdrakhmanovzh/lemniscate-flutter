import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
@CopyWith()
class PostModel {
  final String id;
  final String text;
  final String image;
  @JsonKey(name: "user_id")
  final String userId;
  @JsonKey(name: "created_at")
  String createdAt;
  final List<String> likes;

  PostModel({
    required this.id,
    required this.text,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.likes,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  List<Object?> get props => [id, text, image, userId, createdAt, likes];
}
