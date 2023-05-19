import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/map_provider.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  @override
  void initState() {
    super.initState();
    ref.read(mapProvider).onInit();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(mapProvider);

    return Scaffold(
      body: GoogleMap(
          onMapCreated: (controller) => provider.onMapCreated(controller),
          onTap: (argument) => provider.onMapTapped(argument),
          initialCameraPosition: CameraPosition(
            target: provider.selectedLocation,
            zoom: 12,
          ),
          zoomControlsEnabled: false,
          markers: {
            provider.startMarker != null
                ? provider.startMarker!
                : Marker(
                    markerId: const MarkerId('id'),
                    position: provider.selectedLocation,
                  ),
            provider.endMarker != null
                ? provider.endMarker!
                : Marker(
                    markerId: const MarkerId('marker'),
                    position: provider.selectedLocation,
                  ),
          }),
    );
  }
}
