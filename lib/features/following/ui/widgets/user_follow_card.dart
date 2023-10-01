import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/features/post/presentation/utils/get_formatted_name.dart';
import 'package:lemniscate_flutter/features/user/domain/entities/user_model.dart';

class UserFollowCard extends StatelessWidget {
  final UserModel user;
  const UserFollowCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.secondaryBlack,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primaryGray,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          context.go('/profile/${user.id}');
        },
        child: Text(
          GetFormattedName.getFormattedName(user.name),
          style: const TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
