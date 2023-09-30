import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemniscate_flutter/features/user/domain/entities/user_model.dart';
import 'package:lemniscate_flutter/features/user/domain/repositories/user_repository.dart';

part 'user_state.dart';

abstract class UserCubit extends Cubit<UserState> {
  UserCubit(super.state);

  Future<void> getUsers();
  Future<void> getUser(String userId);
}

class UserCubitImpl extends UserCubit {
  final UserRepository repository;

  UserCubitImpl({required this.repository}) : super(UserInitial());

  @override
  Future<void> getUsers() async {
    try {
      emit(UserLoading());
      final users = await repository.getUsers();
      emit(UserLoaded(users: users));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  @override
  Future<void> getUser(String userId) async {
    try {
      emit(UserLoading());
      final user = await repository.getUser(userId);
      emit(UserLoaded(users: [user]));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
