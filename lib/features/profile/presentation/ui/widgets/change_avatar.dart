import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/features/profile/presentation/cubit/profile_cubit.dart';

class ChangeAvatar extends StatefulWidget {
  final String userName;
  final Function() onAvatarChanged;
  const ChangeAvatar({super.key, required this.userName, required this.onAvatarChanged});

  @override
  State<ChangeAvatar> createState() => _ChangeAvatarState();
}

class _ChangeAvatarState extends State<ChangeAvatar> {
  final picker = ImagePicker();
  File? _postImage;

  Future<void> chooseImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _postImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'change avatar',
              style: TextStyle(
                color: AppColors.primaryWhite,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<ProfileCubit>(context).updateAvatar(
                  _postImage!.path,
                  widget.userName,
                );
                widget.onAvatarChanged();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryGray,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'save',
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            chooseImage();
          },
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.secondaryBlack,
              border: Border.all(
                color: AppColors.primaryGray,
              ),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: _postImage == null
                ? const Center(
                    child: Icon(
                      Icons.add_a_photo,
                      color: AppColors.primaryGray,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(
                      _postImage!,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
