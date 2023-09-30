import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemniscate_flutter/features/profile/domain/repository/profile_repository.dart';

part 'profile_state.dart';

abstract class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(super.state);

  Future<void> updateBio(String bio, String userId);
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
}
