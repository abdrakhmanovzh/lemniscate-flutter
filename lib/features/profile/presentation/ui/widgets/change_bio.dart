import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/core/widgets/custom_input.dart';
import 'package:lemniscate_flutter/features/profile/presentation/cubit/profile_cubit.dart';

class ChangeBio extends StatefulWidget {
  final String userId;
  final Function() onBioChanged;
  const ChangeBio({super.key, required this.userId, required this.onBioChanged});

  @override
  State<ChangeBio> createState() => _ChangeBioState();
}

class _ChangeBioState extends State<ChangeBio> {
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'change bio',
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<ProfileCubit>(context).updateBio(_bioController.text, widget.userId);
                    widget.onBioChanged();
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
            CustomInput(
              controller: _bioController,
              hintText: 'new bio',
              backgroundColor: AppColors.secondaryBlack,
              disabled: state is ProfileLoading,
            ),
            const SizedBox(
              height: 10,
            ),
            if (state is ProfileError)
              Text(
                state.message,
                style: const TextStyle(
                  color: AppColors.primaryRed,
                  fontSize: 14,
                ),
              ),
          ],
        );
      },
    );
  }
}
