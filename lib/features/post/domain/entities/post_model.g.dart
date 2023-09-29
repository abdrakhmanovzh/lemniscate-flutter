// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as String,
      text: json['text'] as String,
      image: json['image'] as String,
      userId: json['user_id'] as String,
      createdAt: json['created_at'] as String,
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'image': instance.image,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'likes': instance.likes,
    };
