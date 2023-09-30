import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/core/widgets/custom_app_bar.dart';
import 'package:lemniscate_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lemniscate_flutter/core/navigation/routes.dart';
import 'package:lemniscate_flutter/features/profile/data/injections/profile_repository_di.dart';
import 'package:lemniscate_flutter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:lemniscate_flutter/features/profile/presentation/ui/widgets/change_bio.dart';
import 'package:lemniscate_flutter/features/profile/presentation/ui/widgets/profile_card.dart';
import 'package:lemniscate_flutter/features/user/presentation/cubit/user_cubit.dart';

class ProfilePage extends StatefulWidget {
  final String? userId;
  const ProfilePage({super.key, this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String bio = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => (ProfileCubitImpl(
        repository: ProfileRepositoryInject.profileRepository(),
      )),
      child: Scaffold(
        backgroundColor: AppColors.primaryBlack,
        appBar: const CustomAppBar(),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              widget.userId == null
                  ? BlocProvider.of<UserCubit>(context).getUser(state.user!.id.toString())
                  : BlocProvider.of<UserCubit>(context).getUser(widget.userId!);
              return BlocBuilder<UserCubit, UserState>(
                builder: (context, userState) {
                  if (userState is UserLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryGray,
                      ),
                    );
                  } else if (userState is UserLoaded) {
                    bio = userState.users.first.bio;
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ProfileCard(
                            user: userState.users.first,
                            bio: bio,
                          ),
                          const SizedBox(height: 20),
                          ChangeBio(
                            userId: state.user!.id,
                            onBioChanged: (newBio) {
                              setState(() {
                                bio = newBio;
                              });
                            },
                          ),
                        ],
                      ),
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
