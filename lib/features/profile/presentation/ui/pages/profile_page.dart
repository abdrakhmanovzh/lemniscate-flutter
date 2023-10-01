import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/core/widgets/custom_app_bar.dart';
import 'package:lemniscate_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lemniscate_flutter/core/navigation/routes.dart';
import 'package:lemniscate_flutter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:lemniscate_flutter/features/profile/presentation/ui/widgets/profile_card.dart';
import 'package:lemniscate_flutter/features/user/presentation/cubit/user_cubit.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFollowed = false;

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUser(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: const CustomAppBar(),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (authState is LoginLoadedState) {
            return BlocBuilder<UserCubit, UserState>(
              builder: (context, userState) {
                if (userState is UserLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryGray,
                    ),
                  );
                } else if (userState is UserLoaded) {
                  final currentUser = BlocProvider.of<AuthCubit>(context).getUser();
                  BlocProvider.of<ProfileCubit>(context).getFollowers(currentUser.id);

                  if (currentUser.id == userState.users.first.id) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go(Routes.myProfile);
                    });
                    return Container();
                  }

                  return BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, profileState) {
                      if (profileState is ProfileLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryGray,
                          ),
                        );
                      } else if (profileState is ProfileFollowers) {
                        isFollowed = profileState.followers.contains(userState.users.first.id);
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              ProfileCard(
                                user: userState.users.first,
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  isFollowed
                                      ? BlocProvider.of<ProfileCubit>(context).unfollowUser(currentUser.id, userState.users.first.id)
                                      : BlocProvider.of<ProfileCubit>(context).followUser(currentUser.id, userState.users.first.id);
                                  setState(() {
                                    isFollowed = !isFollowed;
                                  });
                                },
                                child: Container(
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryBlack,
                                    border: Border.all(
                                      color: AppColors.primaryGray,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    isFollowed ? 'unfollow' : 'follow',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isFollowed ? AppColors.primaryGray : AppColors.primaryWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
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
    );
  }
}
