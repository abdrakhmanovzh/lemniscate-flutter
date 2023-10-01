import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lemniscate_flutter/core/navigation/routes.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/core/widgets/custom_app_bar.dart';
import 'package:lemniscate_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lemniscate_flutter/features/post/presentation/cubit/post_cubit.dart';
import 'package:lemniscate_flutter/features/post/presentation/ui/post_card_widget.dart';
import 'package:lemniscate_flutter/features/user/presentation/cubit/user_cubit.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
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
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (authState is LoginLoadedState) {
            final currentUser = BlocProvider.of<AuthCubit>(context).getUser();
            BlocProvider.of<PostCubit>(context).getLikedPosts(currentUser.id);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  BlocBuilder<PostCubit, PostState>(
                    builder: (context, state) {
                      if (state is PostLoaded) {
                        final likedPosts = state.posts;
                        return BlocBuilder<UserCubit, UserState>(
                          builder: (context, userState) {
                            if (userState is UserLoaded) {
                              final users = userState.users;
                              return likedPosts.isNotEmpty
                                  ? Wrap(
                                      runSpacing: 20,
                                      children: [
                                        for (final post in likedPosts)
                                          PostCardWidget(
                                            post: post,
                                            author: users.firstWhere((user) => user.id == post.userId),
                                          ),
                                      ],
                                    )
                                  : Container(
                                      constraints: BoxConstraints(
                                        minHeight: MediaQuery.of(context).size.height * 0.7,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'no posts were liked',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.primaryWhite,
                                          ),
                                        ),
                                      ),
                                    );
                            } else if (userState is UserError) {
                              final error = userState.message;
                              return Center(
                                child: Text(
                                  error,
                                  style: const TextStyle(color: AppColors.primaryWhite),
                                ),
                              );
                            } else {
                              return Container(
                                constraints: BoxConstraints(
                                  minHeight: MediaQuery.of(context).size.height * 0.65,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryGray,
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      } else if (state is PostLoading) {
                        return Container(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.8,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryGray,
                            ),
                          ),
                        );
                      } else if (state is PostError) {
                        final error = state.message;
                        return Container(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.8,
                          ),
                          child: Center(
                            child: Text(
                              error,
                              style: const TextStyle(color: AppColors.primaryWhite),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
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
