import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lemniscate_flutter/core/navigation/routes.dart';
import 'package:lemniscate_flutter/core/services/supabase_service.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/core/widgets/custom_app_bar.dart';
import 'package:lemniscate_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lemniscate_flutter/features/profile/data/injections/profile_repository_di.dart';
import 'package:lemniscate_flutter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:lemniscate_flutter/features/profile/presentation/ui/widgets/change_avatar.dart';
import 'package:lemniscate_flutter/features/profile/presentation/ui/widgets/change_bio.dart';
import 'package:lemniscate_flutter/features/profile/presentation/ui/widgets/profile_card.dart';
import 'package:lemniscate_flutter/features/user/presentation/cubit/user_cubit.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: const CustomAppBar(),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (authState is LoginLoadedState) {
            final currentUser = BlocProvider.of<AuthCubit>(context).getUser();
            BlocProvider.of<UserCubit>(context).getUser(currentUser.id);
            return BlocProvider<ProfileCubit>(
              create: (context) => (ProfileCubitImpl(
                repository: ProfileRepositoryInject.profileRepository(),
              )),
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, userState) {
                  if (userState is UserLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryGray,
                      ),
                    );
                  } else if (userState is UserLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ProfileCard(
                              user: userState.users.first,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ChangeBio(
                              userId: SupabaseService.supabase.auth.currentUser!.id,
                              onBioChanged: () {
                                BlocProvider.of<UserCubit>(context).getUser(currentUser.id);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ChangeAvatar(
                              userName: SupabaseService.supabase.auth.currentUser!.email!,
                              onAvatarChanged: () {
                                BlocProvider.of<UserCubit>(context).getUser(SupabaseService.supabase.auth.currentUser!.id);
                              },
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<AuthCubit>(context).logout();
                              },
                              child: Container(
                                width: double.maxFinite,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryBlack,
                                  border: Border.all(color: AppColors.primaryGray),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'logout',
                                    style: TextStyle(
                                      color: AppColors.primaryWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
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
