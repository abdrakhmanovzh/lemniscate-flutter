import 'package:flutter/material.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/core/widgets/custom_app_bar.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
          "Following Page",
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
