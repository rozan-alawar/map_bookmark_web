import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal/controllers/favorite_provider.dart';
import 'package:minimal/data/models/auth_response.dart';
import 'package:minimal/utils/cache_helper.dart';
import 'package:minimal/utils/styles/color_manager.dart';

import '../data/api/api_service/api_services.dart';
import '../routes.dart';

class AuthNotifier extends ChangeNotifier {
  bool loading = false;

  final Ref ref;
  AuthNotifier({required this.ref});
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  User? user = CacheHelper.getData(key: 'user') != null
      ? User.fromJson(json.decode(CacheHelper.getData(key: 'user')))
      : null;

  //--------------------------- LOGIN ---------------------------------
  void login(
      {required GlobalKey<FormState> formKey,
      required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      final response = await ref.read(apiServices).login(
            username: userNameController.text.trim(),
            password: passwordController.text.trim(),
          );

      if (response.code == 201) {
        loading = false;
        user = response.data;
        await CacheHelper.saveData(
            key: 'user', value: json.encode(user!.toJson()));
        print(CacheHelper.getData(key: 'user'));
        ref.read(favoriteProvider).getFavorites(context: context);
        Navigator.pushNamed(context, Routes.home);
        notifyListeners();
      } else {
        loading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.message ?? ''),
          elevation: 5,
          backgroundColor: ColorManager.red,
        ));
      }
      notifyListeners();
    }
  }

  //--------------------------- REGISTER ---------------------------------
  void signUp(
      {required GlobalKey<FormState> formKey,
      required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      final response = await ref.read(apiServices).signup(
            username: userNameController.text.trim(),
            email: emailController.text.trim(),
            mobile: mobileController.text.trim(),
            password: passwordController.text.trim(),
          );

      if (response.code == 201) {
        loading = false;
        user = response.data;
        await CacheHelper.saveData(key: 'user', value: user);
        ref.read(favoriteProvider).getFavorites(context: context);

        Navigator.pushNamed(context, Routes.home);
        notifyListeners();
      } else {
        loading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.message ?? ''),
          elevation: 5,
          backgroundColor: ColorManager.red,
        ));
      }
      notifyListeners();
    }
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthNotifier(ref: ref));
