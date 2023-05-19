import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minimal/controllers/favorite_provider.dart';
import 'package:minimal/controllers/map_provider.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    // ref.read(favoriteProvider).getFavorites(context: context);
    return Scaffold(
      body: ref.watch(favoriteProvider).favorites == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Container(
              constraints: const BoxConstraints(maxWidth: double.infinity),
              child: ListView.builder(
                itemCount: ref.watch(favoriteProvider).favorites!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.08),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
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
                                      onMapCreated: (controller) => ref
                                          .watch(mapProvider)
                                          .onMapCreated(controller),
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            double.tryParse(ref
                                                    .watch(favoriteProvider)
                                                    .favorites![index]
                                                    .lat!) ??
                                                0,
                                            double.tryParse(ref
                                                    .watch(favoriteProvider)
                                                    .favorites![index]
                                                    .long!) ??
                                                0),
                                        zoom: 15,
                                      ),
                                      zoomControlsEnabled: false,
                                      scrollGesturesEnabled: false,
                                      markers: {
                                        Marker(
                                          markerId:
                                              const MarkerId('new_marker'),
                                          position: LatLng(
                                              double.tryParse(ref
                                                      .watch(favoriteProvider)
                                                      .favorites![index]
                                                      .lat!) ??
                                                  0,
                                              double.tryParse(ref
                                                      .watch(favoriteProvider)
                                                      .favorites![index]
                                                      .long!) ??
                                                  0),
                                        )
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    const Text(
                                      'Country',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      ref
                                          .watch(favoriteProvider)
                                          .favorites![index]
                                          .title!
                                          .toString(),
                                      style: const TextStyle(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    const Text(
                                      'Descreption',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      ref
                                          .watch(favoriteProvider)
                                          .favorites![index]
                                          .desc!
                                          .toString(),
                                      style: const TextStyle(),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
