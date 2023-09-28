import 'package:flutter/material.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: Center(
        child: Text(
          'something is wrong...',
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
