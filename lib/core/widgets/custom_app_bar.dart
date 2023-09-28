import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lemniscate_flutter/core/utils/app_assets.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryBlack,
      shape: const Border(
        bottom: BorderSide(
          color: AppColors.primaryGray,
        ),
      ),
      leadingWidth: 72,
      leading: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            AppAssets.logo,
            color: AppColors.primaryWhite,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          child: Row(
            children: [
              SvgPicture.asset(
                AppAssets.login,
                height: 16,
                color: AppColors.primaryWhite,
              ),
              const SizedBox(width: 8),
              const Text(
                'sign in',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
