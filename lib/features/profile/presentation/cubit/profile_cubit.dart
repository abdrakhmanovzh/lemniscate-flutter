import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemniscate_flutter/features/profile/domain/repository/profile_repository.dart';

part 'profile_state.dart';

abstract class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(super.state);

  Future<void> updateBio(String bio, String userId);
  Future<void> updateAvatar(String avatar, String userName);
  Future<void> getFollowers(String from);
  Future<void> followUser(String from, String to);
  Future<void> unfollowUser(String from, String to);
}

class ProfileCubitImpl extends ProfileCubit {
  final ProfileRepository repository;

  ProfileCubitImpl({required this.repository}) : super(ProfileInitial());

  @override
  Future<void> updateBio(String bio, String userId) async {
    try {
      emit(ProfileLoading());
      await repository.updateBio(bio, userId);
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  @override
  Future<void> updateAvatar(String avatar, String userName) async {
    try {
      emit(ProfileLoading());
      await repository.updateAvatar(avatar, userName);
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  @override
  Future<void> getFollowers(String from) async {
    try {
      emit(ProfileLoading());
      final followers = await repository.getFollowers(from);
      emit(ProfileFollowers(followers: followers));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  @override
  Future<void> followUser(String from, String to) async {
    try {
      await repository.followUser(from, to);
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  @override
  Future<void> unfollowUser(String from, String to) async {
    try {
      await repository.unfollowUser(from, to);
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
