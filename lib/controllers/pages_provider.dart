import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal/pages/taps/fav_page.dart';
import 'package:minimal/pages/taps/profile_page.dart';

import '../pages/taps/map_page.dart';

class PagesNotifier extends ChangeNotifier {
  int selectedIndex = 0;

  onTap(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  final List<Widget> screens = [
    const MapPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];
}

final pagesProvider = ChangeNotifierProvider((ref) => PagesNotifier());
