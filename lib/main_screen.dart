import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lemniscate_flutter/core/navigation/cubit/navigation_cubit.dart';
import 'package:lemniscate_flutter/core/navigation/routes.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/core/widgets/named_navbar_item.dart';
import 'package:lemniscate_flutter/features/auth/data/injections/auth_repository_di.dart';
import 'package:lemniscate_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lemniscate_flutter/features/post/data/injections/post_repository_di.dart';
import 'package:lemniscate_flutter/features/post/presentation/cubit/post_cubit.dart';
import 'package:lemniscate_flutter/features/profile/data/injections/profile_repository_di.dart';
import 'package:lemniscate_flutter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:lemniscate_flutter/features/user/data/injections/user_repository_di.dart';
import 'package:lemniscate_flutter/features/user/presentation/cubit/user_cubit.dart';

class MainScreen extends StatelessWidget {
  final Widget screen;

  MainScreen({super.key, required this.screen});

  final tabs = [
    NamedNavbarItem(
      initialLocation: Routes.home,
      icon: const Icon(
        Icons.home_outlined,
        size: 22,
      ),
      label: 'home',
    ),
    NamedNavbarItem(
      initialLocation: Routes.liked,
      icon: const Icon(
        Icons.favorite_outline,
        size: 22,
      ),
      label: 'liked',
    ),
    NamedNavbarItem(
      initialLocation: Routes.following,
      icon: const Icon(
        Icons.people_outline,
        size: 22,
      ),
      label: 'following',
    ),
    NamedNavbarItem(
      initialLocation: Routes.myProfile,
      icon: const Icon(
        Icons.person_outline,
        size: 22,
      ),
      label: 'profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<PostCubit>(
            create: (context) => PostCubitImpl(repository: PostRepositoryInject.postRepository()!),
          ),
          BlocProvider<UserCubit>(
            create: (context) => UserCubitImpl(repository: UserRepositoryInject.userRepository()!),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubitImpl(authRepository: AuthRepositoryInject.authRepository()!),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubitImpl(repository: ProfileRepositoryInject.profileRepository()),
          ),
        ],
        child: screen,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, tabs),
    );
  }

  _buildBottomNavigationBar(mContext, List<NamedNavbarItem> tabs) => BlocBuilder<NavigationCubit, NavigationState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.primaryGray,
                  width: 1,
                ),
              ),
              color: AppColors.secondaryBlack,
            ),
            child: BottomNavigationBar(
              onTap: (value) {
                if (state.index != value) {
                  context.read<NavigationCubit>().getNavbarItem(value);
                  context.go(tabs[value].initialLocation);
                }
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
              enableFeedback: false,
              elevation: 0,
              backgroundColor: AppColors.secondaryBlack,
              unselectedItemColor: AppColors.primaryWhite,
              selectedItemColor: AppColors.primaryWhite,
              items: tabs,
              currentIndex: state.index,
              type: BottomNavigationBarType.fixed,
            ),
          );
        },
      );
}
