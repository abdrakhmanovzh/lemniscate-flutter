import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lemniscate_flutter/core/globals/keys.dart';
import 'package:lemniscate_flutter/core/navigation/cubit/navigation_cubit.dart';
import 'package:lemniscate_flutter/core/navigation/routes.dart';
import 'package:lemniscate_flutter/core/widgets/error_page.dart';
import 'package:lemniscate_flutter/features/following/ui/pages/following_page.dart';
import 'package:lemniscate_flutter/features/home/ui/pages/home_page.dart';
import 'package:lemniscate_flutter/features/liked/ui/pages/liked_page.dart';
import 'package:lemniscate_flutter/features/profile/ui/pages/profile_page.dart';
import 'package:lemniscate_flutter/main_screen.dart';

class CustomRouter {
  static final router = GoRouter(
    initialLocation: Routes.home,
    navigatorKey: Keys.rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: Keys.shellNavigatorKey,
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => NavigationCubit(),
            child: MainScreen(screen: child),
          );
        },
        routes: [
          GoRoute(
            path: Routes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: Routes.liked,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LikedPage(),
            ),
          ),
          GoRoute(
            path: Routes.following,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FollowingPage(),
            ),
          ),
          GoRoute(
            path: Routes.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfilePage(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}
