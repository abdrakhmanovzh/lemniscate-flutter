import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';
import 'package:lemniscate_flutter/features/post/presentation/cubit/post_cubit.dart';
import 'package:lemniscate_flutter/features/user/presentation/utils/get_user_avatar.dart';
import 'package:uuid/uuid.dart';

class PostCreateWidget extends StatefulWidget {
  const PostCreateWidget({super.key});

  @override
  State<PostCreateWidget> createState() => _PostCreateWidgetState();
}

class _PostCreateWidgetState extends State<PostCreateWidget> {
  final TextEditingController _postTextController = TextEditingController();
  final picker = ImagePicker();
  File? _postImage;
  Uuid uuid = const Uuid();

  Future<void> chooseImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _postImage = File(image.path);
      });
    }
  }

  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          final currentUser = state.user;
          return BlocBuilder<PostCubit, PostState>(
            builder: (context, postState) {
              return Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBlack,
                  border: Border.all(
                    color: AppColors.primaryGray,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            GetUserAvatar.getAvatar(currentUser!.email ?? ''),
                          ),
                          backgroundColor: AppColors.neutralGray,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _postTextController,
                            style: const TextStyle(
                              color: AppColors.primaryWhite,
                              fontSize: 14,
                            ),
                            cursorColor: AppColors.neutralGray,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'anything new?',
                              hintStyle: TextStyle(
                                color: AppColors.neutralGray,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            chooseImage();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGray,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'add image',
                              style: TextStyle(
                                color: AppColors.primaryWhite,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<PostCubit>(context).createPost(PostModel.fromJson({
                              'id': uuid.v1(),
                              'text': _postTextController.text,
                              'image': _postImage?.path ?? '',
                              'user_id': currentUser.id,
                              'likes': [],
                              'created_at': DateTime.now().toIso8601String(),
                            }));
                            _postTextController.clear();
                            setState(() {
                              _postImage = null;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGray,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'post',
                              style: TextStyle(
                                color: AppColors.primaryWhite,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_postImage != null)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _postImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
