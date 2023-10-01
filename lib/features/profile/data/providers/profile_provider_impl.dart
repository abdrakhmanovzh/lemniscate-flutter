import 'dart:io';

import 'package:lemniscate_flutter/features/profile/data/providers/profile_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileProviderImpl implements ProfileProvider {
  @override
  Future<bool> updateBio(String bio, String userId) async {
    try {
      await Supabase.instance.client.from('users').update({'bio': bio}).eq('id', userId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateAvatar(String avatar, String userName) async {
    try {
      await Supabase.instance.client.storage.from('avatars').update(userName, File(avatar));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> getFollowers(String from) async {
    try {
      final response = await Supabase.instance.client.from('follow').select().eq('from', from);
      final followers = response.map((e) => e['to']).toList().cast<String>();
      return followers;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> followUser(String from, String to) async {
    try {
      final response = await Supabase.instance.client.from('follow').select().eq('from', from);
      if (response.length > 0) {
        await Supabase.instance.client.from('follow').update({'to': to}).eq('from', from);
      } else {
        await Supabase.instance.client.from('follow').insert({'from': from, 'to': to});
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> unfollowUser(String from, String to) async {
    try {
      await Supabase.instance.client.from('follow').delete().eq('from', from).eq('to', to);
      return true;
    } catch (e) {
      return false;
    }
  }
}
