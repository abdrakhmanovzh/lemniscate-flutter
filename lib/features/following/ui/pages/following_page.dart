import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lemniscate_flutter/core/navigation/routes.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/core/widgets/custom_app_bar.dart';
import 'package:lemniscate_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lemniscate_flutter/features/following/ui/widgets/user_follow_card.dart';
import 'package:lemniscate_flutter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:lemniscate_flutter/features/user/presentation/cubit/user_cubit.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({super.key});

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is LoginLoadedState) {
              final currentUser = BlocProvider.of<AuthCubit>(context).getUser();
              BlocProvider.of<ProfileCubit>(context).getFollowers(currentUser.id);
              return BlocBuilder<UserCubit, UserState>(
                builder: (context, userState) {
                  if (userState is UserLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryGray,
                      ),
                    );
                  } else if (userState is UserError) {
                    return Center(
                      child: Text(
                        userState.message,
                        style: const TextStyle(
                          color: AppColors.primaryGray,
                        ),
                      ),
                    );
                  } else if (userState is UserLoaded) {
                    return BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, profileState) {
                        if (profileState is ProfileLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryGray,
                            ),
                          );
                        } else if (profileState is ProfileError) {
                          return Center(
                            child: Text(
                              profileState.message,
                              style: const TextStyle(
                                color: AppColors.primaryGray,
                              ),
                            ),
                          );
                        } else if (profileState is ProfileFollowers) {
                          final followingIds = profileState.followers;
                          final following = userState.users.where((user) => followingIds.contains(user.id)).toList();
                          if (following.isNotEmpty) {
                            return SingleChildScrollView(
                              child: Wrap(
                                runSpacing: 20,
                                children: [
                                  for (final user in following)
                                    UserFollowCard(
                                      user: user,
                                    ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'no following',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.primaryWhite,
                                ),
                              ),
                            );
                          }
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go(Routes.login);
              });
              return Container();
            }
          },
        ),
      ),
    );
  }
}
