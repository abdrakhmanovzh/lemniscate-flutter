import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lemniscate_flutter/core/navigation/routes.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/core/widgets/custom_app_bar.dart';
import 'package:lemniscate_flutter/core/widgets/custom_input.dart';
import 'package:lemniscate_flutter/features/auth/presentation/cubit/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passwordObscured = true;
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
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: const CustomAppBar(),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.secondaryBlack,
              border: Border.all(color: AppColors.primaryGray),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Center(
                  child: Text(
                    'sign up',
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomInput(
                        controller: _emailController,
                        isObscured: false,
                        hintText: 'email',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomInput(
                        controller: _passwordController,
                        isObscured: passwordObscured,
                        hintText: 'password',
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              passwordObscured = !passwordObscured;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              passwordObscured ? Icons.visibility : Icons.visibility_off,
                              size: 18,
                              color: AppColors.neutralGray,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthCubit>(context).register(_emailController.text, _passwordController.text, _postImage!.path);
                        },
                        child: Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryGray,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              state is RegisterLoadingState ? 'loading' : 'register',
                              style: const TextStyle(
                                color: AppColors.primaryWhite,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      state is RegisterErrorState
                          ? Text(
                              state.message,
                              style: const TextStyle(color: AppColors.primaryRed),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              color: AppColors.primaryGray,
                              thickness: 1,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'or',
                            style: TextStyle(
                              color: AppColors.primaryWhite,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.primaryGray,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(Routes.login);
                        },
                        child: Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryGray,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                            child: Text(
                              'sign in',
                              style: TextStyle(
                                color: AppColors.primaryWhite,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
