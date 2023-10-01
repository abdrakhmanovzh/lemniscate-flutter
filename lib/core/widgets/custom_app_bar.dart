import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lemniscate_flutter/core/utils/app_assets.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryBlack,
      shape: const Border(
        bottom: BorderSide(
          color: AppColors.primaryGray,
        ),
      ),
      centerTitle: true,
      leadingWidth: 72,
      leading: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            AppAssets.logo,
            color: AppColors.primaryWhite,
          ),
        ),
      ),
      title: Text(
        title ?? 'lemniscate',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
