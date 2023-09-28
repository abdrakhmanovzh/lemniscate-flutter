import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemniscate_flutter/core/navigation/routes.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(bottomNavItems: Routes.home, index: 0));

  void getNavbarItem(int index) {
    switch (index) {
      case 0:
        emit(const NavigationState(bottomNavItems: Routes.home, index: 0));
        break;
      case 1:
        emit(const NavigationState(bottomNavItems: Routes.liked, index: 1));
        break;
      case 2:
        emit(const NavigationState(bottomNavItems: Routes.following, index: 2));
        break;
      case 3:
        emit(const NavigationState(bottomNavItems: Routes.profile, index: 3));
        break;
    }
  }
}
