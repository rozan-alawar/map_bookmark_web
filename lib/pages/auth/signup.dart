import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal/utils/extensions/validation_extension.dart';
import 'package:minimal/utils/styles/styles_manager.dart';

import '../../../utils/styles/values_manager.dart';
import '../../common_widget/button.dart';
import '../../common_widget/page_header.dart';

import '../../common_widget/text_field.dart';
import '../../controllers/auth_provider.dart';
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
    final auth = ref.watch(authProvider.notifier);
    final signupKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: 900,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p32),
              child: Form(
                key: signupKey,
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
                      controller: auth.userNameController,
                      hintText: 'username',
                      validator: (value) =>
                          value!.isEmpty ? 'Enter correct name' : null,
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      controller: auth.emailController,
                      hintText: 'email',
                      validator: (value) =>
                          value!.isEmpty || !value.isValidEmail
                              ? 'Enter correct email'
                              : null,
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      controller: auth.mobileController,
                      hintText: 'Phone Number',
                      validator: (value) {
                        return value!.isEmpty ? 'Enter correct phone' : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      controller: auth.passwordController,
                      isPassword: true,
                      hintText: 'password',
                      validator: (value) =>
                          Validations.passwordValidator(value!),
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      isPassword: true,
                      controller: auth.confirmController,
                      hintText: 'Confirm Password',
                      validator: (value) => Validations.confirmPassValidator(
                        value!.trim(),
                        auth.passwordController.text.trim(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    AbsorbPointer(
                      absorbing: auth.loading,
                      child: CommonButton(
                        onPressed: () => ref
                            .read(authProvider)
                            .signUp(formKey: signupKey, context: context),
                        color: auth.loading
                            ? ColorManager.lightBlack
                            : ColorManager.black,
                        width: 500.w,
                        child: auth.loading
                            ? const CircularProgressIndicator()
                            : const Text('Sign Up'),
                      ),
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
