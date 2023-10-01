import 'package:flutter/material.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/features/post/presentation/utils/get_formatted_name.dart';
import 'package:lemniscate_flutter/features/user/domain/entities/user_model.dart';
import 'package:lemniscate_flutter/features/user/presentation/utils/get_user_avatar.dart';

class ProfileCard extends StatefulWidget {
  final UserModel user;
  const ProfileCard({super.key, required this.user});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String bio = '';
  String avatar = '';

  @override
  void initState() {
    bio = widget.user.bio;
    avatar = widget.user.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: bio.isNotEmpty ? 220 : 190,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryGray),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.secondaryBlack,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 110,
              width: MediaQuery.of(context).size.width - 42,
              decoration: const BoxDecoration(
                color: AppColors.secondaryGray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: null,
            right: null,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(GetUserAvatar.getAvatar(avatar)),
              backgroundColor: AppColors.primaryGray,
            ),
          ),
          Positioned(
            top: 150,
            child: Text(
              GetFormattedName.getFormattedName(widget.user.name),
              style: const TextStyle(
                color: AppColors.primaryWhite,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            top: 185,
            child: bio.isNotEmpty
                ? Text(
                    bio,
                    style: const TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 16,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
