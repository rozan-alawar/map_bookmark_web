import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minimal/controllers/map_provider.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(mapProvider);

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(maxWidth: double.infinity),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondPage(heroTag: index)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: index,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 200,
                            child: GoogleMap(
                              onMapCreated: (controller) =>
                                  provider.onMapCreated(controller),
                              initialCameraPosition: CameraPosition(
                                target: provider.selectedLocation,
                                zoom: 15,
                              ),
                              zoomControlsEnabled: false,
                              scrollGesturesEnabled: false,
                              markers: {
                                Marker(
                                  markerId: const MarkerId('new_marker'),
                                  position: provider.selectedLocation,
                                )
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(
                      'Gaza',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecondPage extends ConsumerWidget {
  final int heroTag;

  const SecondPage({Key? key, required this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(mapProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: SizedBox(
                  height: 400,
                  child: Hero(
                    tag: heroTag,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AbsorbPointer(
                        child: GoogleMap(
                          onMapCreated: (controller) =>
                              provider.onMapCreated(controller),
                          onTap: (argument) => provider.onMapTapped(argument),
                          initialCameraPosition: CameraPosition(
                            target: provider.selectedLocation,
                            zoom: 15,
                          ),
                          zoomControlsEnabled: false,
                          scrollGesturesEnabled: false,
                          markers: {
                            Marker(
                              markerId: const MarkerId('new_marker'),
                              position: provider.selectedLocation,
                            )
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              "Gaza | Gaza Strip ",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          )
        ],
      ),
    );
  }
}

final List<String> _images = [
  'https://images.pexels.com/photos/167699/pexels-photo-167699.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
  'https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  'https://images.pexels.com/photos/273935/pexels-photo-273935.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  'https://images.pexels.com/photos/1591373/pexels-photo-1591373.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  'https://images.pexels.com/photos/462024/pexels-photo-462024.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  'https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
];
