import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../common_widget/text_field.dart';
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
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => provider.onMapCreated(controller),
            onTap: (argument) => provider.onMapTapped(argument),
            initialCameraPosition: CameraPosition(
              target: provider.selectedLocation,
              zoom: 15,
            ),
            zoomControlsEnabled: false,
            markers: {
              Marker(
                markerId: const MarkerId('new_marker'),
                position: provider.selectedLocation,
              )
            },
          ),
          Positioned(
            top: 10,
            left: 300.w,
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(7.r),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  CommonTextField(
                    controller: provider.cityController,
                    hintText: 'Search by city',
                    width: 1500.w,
                  ),
                  Positioned(
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        ref.read(mapProvider).getPlaceByID(
                              provider.cityController.text,
                            );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
