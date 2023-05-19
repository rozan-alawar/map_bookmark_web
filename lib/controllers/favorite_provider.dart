import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal/data/models/fav_response.dart';
import 'package:minimal/utils/cache_helper.dart';
import 'package:minimal/utils/styles/color_manager.dart';

import '../data/api/api_service/api_services.dart';
import '../routes.dart';

class FavoriteNotifier extends ChangeNotifier {
  final Ref ref;
  FavoriteNotifier({required this.ref});

  bool loading = false;
  List<Favorite>? favorites;

  //--------------------------- FAVORITES ---------------------------------
  void getFavorites({required BuildContext context}) async {
    loading = true;
    notifyListeners();
    final response = await ref.read(apiServices).favorites();
    if (response.code == 200) {
      loading = false;
      favorites = response.data as List<Favorite>;

      print(CacheHelper.getData(key: 'favorite'));
      Navigator.pushNamed(context, Routes.home);
      notifyListeners();
    } else {
      loading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.massege ?? ''),
        elevation: 5,
        backgroundColor: ColorManager.red,
      ));
    }
    notifyListeners();
  }
}

final favoriteProvider =
    ChangeNotifierProvider((ref) => FavoriteNotifier(ref: ref));
