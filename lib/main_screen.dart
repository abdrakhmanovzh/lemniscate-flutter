import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lemniscate_flutter/core/navigation/cubit/navigation_cubit.dart';
import 'package:lemniscate_flutter/core/navigation/routes.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/core/widgets/named_navbar_item.dart';

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
      initialLocation: Routes.profile,
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
      body: screen,
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
