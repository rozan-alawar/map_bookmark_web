import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal/controllers/auth_provider.dart';
import 'package:minimal/controllers/map_provider.dart';
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

  //--------------------------- FAVORITES ---------------------------------
  void addToFavorites({required BuildContext context}) async {
    var map = ref.read(mapProvider);
    var location = map.selectedLocation;
    notifyListeners();
    final response = await ref.read(apiServices).addToFavorites(
          lat: '${location.latitude}',
          long: '${location.longitude}',
          title: await map.getAddressFromLatLong(location),
          username: ref.read(authProvider).user!.username!,
        );
    if (response.code == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(response.massege ?? "The place add to favorite successfully"),
        elevation: 5,
        backgroundColor: ColorManager.green,
      ));
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
