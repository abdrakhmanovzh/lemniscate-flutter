import 'dart:io';

import 'package:lemniscate_flutter/features/post/data/providers/post_api_provider.dart';
import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostApiProviderImpl implements PostApiProvider {
  @override
  Future<List<dynamic>> getPosts() async {
    try {
      final response = await Supabase.instance.client.from('posts').select().order('created_at') as List<dynamic>?;
      if (response?.isNotEmpty ?? false) {
        return response?.map((e) => PostModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> createPost(PostModel post) async {
    try {
      await Supabase.instance.client.storage.from('images').upload(post.image, File(post.image));
      await Supabase.instance.client.from('posts').insert(post.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> likePost(String postId, String userId) async {
    try {
      final response = await Supabase.instance.client.from('posts').select().eq('id', postId);
      final post = PostModel.fromJson(response[0]);
      final likes = post.likes;
      if (likes.contains(userId)) {
        likes.remove(userId);
      } else {
        likes.add(userId);
      }

      await Supabase.instance.client.from('posts').update(post.toJson()).eq('id', postId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<dynamic>> getLikedPosts(String userId) async {
    try {
      final response = await Supabase.instance.client.from('posts').select().order('created_at') as List<dynamic>?;
      final posts = response?.map((e) => PostModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];
      final likedPosts = posts.where((element) => element.likes.contains(userId)).toList();
      return likedPosts;
    } catch (e) {
      throw Exception(e);
    }
  }
}
