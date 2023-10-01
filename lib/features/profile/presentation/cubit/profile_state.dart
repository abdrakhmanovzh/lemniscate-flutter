part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileFollowers extends ProfileState {
  final List<String> followers;

  const ProfileFollowers({required this.followers});

  @override
  List<Object> get props => [followers];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
