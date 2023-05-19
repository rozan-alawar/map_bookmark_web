import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal/controllers/pages_provider.dart';

import '../common_widget/text_field.dart';
import '../controllers/favorite_provider.dart';
import '../controllers/map_provider.dart';
// import 'package:flutter/material/menu_anchor.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.map),
      label: 'Map',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bookmark_border_outlined),
      activeIcon: Icon(Icons.location_on_sharp),
      label: 'Favorite Locations',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_rounded),
      activeIcon: Icon(Icons.person_rounded),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(pagesProvider);
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;
    final bool isLargeScreen = width > 800;

    return Scaffold(
      bottomNavigationBar: isSmallScreen
          ? BottomNavigationBar(
              items: _navBarItems,
              currentIndex: provider.selectedIndex,
              onTap: (int index) {
                provider.selectedIndex == 1
                    ? ref.read(favoriteProvider).getFavorites(context: context)
                    : null;
                print(provider.selectedIndex);
                print(ref.read(favoriteProvider).favorites);

                provider.onTap(index);
              })
          : null,
      body: Stack(
        children: [
          Row(
            children: <Widget>[
              if (!isSmallScreen)
                NavigationRail(
                  selectedIndex: provider.selectedIndex,
                  onDestinationSelected: (int index) {
                    provider.selectedIndex == 1
                        ? ref
                            .read(favoriteProvider)
                            .getFavorites(context: context)
                        : null;
                    print(provider.selectedIndex);
                    print(ref.read(favoriteProvider).favorites);

                    provider.onTap(index);
                  },
                  extended: isLargeScreen,
                  destinations: _navBarItems
                      .map((item) => NavigationRailDestination(
                          icon: item.icon,
                          selectedIcon: item.activeIcon,
                          label: Text(
                            item.label!,
                          )))
                      .toList(),
                ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: provider.screens[provider.selectedIndex])
            ],
          ),
          Positioned(
            top: 250.h,
            left: 10.w,
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(7.r),
              child: CommonTextField(
                controller: ref.watch(mapProvider).cityController,
                hintText: 'Search by city name',
                width: 600.w,
                onChanged: (value) => print(value),
                onSaved: () async {
                  var place = await ref
                      .read(mapProvider)
                      .getPlace(ref.watch(mapProvider).cityController.text);

                  await ref.read(mapProvider).goToPlace(place);
                },
                suffix: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          Positioned(
            top: 330.h,
            left: 10.w,
            child: InkWell(
              onTap: () {
                ref.read(favoriteProvider).addToFavorites(context: context);
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.pin_drop,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text('Add to favorite'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
