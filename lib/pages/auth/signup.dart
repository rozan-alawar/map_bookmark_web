import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal/utils/extensions/validation_extension.dart';
import 'package:minimal/utils/styles/styles_manager.dart';

import '../../../utils/styles/values_manager.dart';
import '../../common_widget/button.dart';
import '../../common_widget/page_header.dart';

import '../../common_widget/text_field.dart';
import '../../routes.dart';
import '../../utils/constants/controllers.dart';
import '../../utils/constants/validations.dart';
import '../../utils/styles/color_manager.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final loginKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: 750,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p32),
              child: Form(
                key: loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    const PageHeader(firstText: 'Sign', secondText: 'Up'),
                    const SizedBox(height: 20),
                    Text(
                      'Create new account',
                      style: getRegularStyle(color: ColorManager.grey),
                    ),
                    const SizedBox(height: 40),
                    CommonTextField(
                      controller: nameController,
                      hintText: 'Full name',
                      validator: (value) =>
                          value!.isEmpty ? 'Enter correct name' : null,
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      controller: TextEditingController(),
                      hintText: 'email',
                      validator: (value) =>
                          value!.isEmpty || !value.isValidEmail
                              ? 'Enter correct email'
                              : null,
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      controller: phoneController,
                      hintText: 'Phone Number',
                      validator: (value) {
                        return value!.isEmpty ? 'Enter correct phone' : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      controller: TextEditingController(),
                      isPassword: true,
                      hintText: 'password',
                      validator: (value) =>
                          Validations.passwordValidator(value!),
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      isPassword: true,
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      validator: (value) => Validations.confirmPassValidator(
                        value!.trim(),
                        passwordController.text.trim(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    CommonButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.home);
                      },
                      color: ColorManager.black,
                      width: 500.w,
                      child: const Text('Sign Up'),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
