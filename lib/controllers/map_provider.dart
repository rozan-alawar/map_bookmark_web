import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapNotifier extends ChangeNotifier {
  TextEditingController cityController = TextEditingController();
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  LatLng selectedLocation = const LatLng(31.5017, 34.4669);
  late LatLng? tappedLocation;
  Position? position;
  String currentAddress = '';
  String startAddress = '';
  LatLng? currentLocation;

  double distance = 0;
  bool distanceCal = false;

  bool isLoading = false;

  void calculateDistance(
      BuildContext context, LatLng? startLocation, LatLng? endLocation) async {
    if (startLocation == null || endLocation == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Please Enter both First and Second locations.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Calculate the distance between the two locations
    double calculatedDistance = Geolocator.distanceBetween(
      startLocation.latitude,
      startLocation.longitude,
      endLocation.latitude,
      endLocation.longitude,
    );

    distance = calculatedDistance;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Distance'),
            content: Text('The Distance between givien cities is $distance'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    isLoading = true;
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    isLoading = false;
    currentLocation = LatLng(position.latitude, position.longitude);
    notifyListeners();
  }

  Future<String> getAddressFromLatLong(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$key';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      if (jsonResult['status'] == 'OK') {
        print(jsonResult['results'][0]['formatted_address']);
        return jsonResult['results'][0]['formatted_address'];
      }
    }
    return 'Gaza';
  }

  void onInit() {
    _getCurrentPosition();
    tappedLocation = selectedLocation;
  }

  void setSelectedLocation(LatLng location) {
    selectedLocation = location;
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onMapTapped(LatLng location) async {
    selectedLocation = location;
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 12,
        ),
      ),
    );
    getAddressFromLatLong(location);
    notifyListeners();
  }

  String key = 'AIzaSyB4nJ_35oFFm0vh6dBeXdncZfWc7Jouhwc';

  Future<String> getPlaceByID(String input) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);
    final placeId = json['candidates'][0]['place_id'];
    print(placeId);

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    String placeId = await getPlaceByID(input);
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&inputtype=textquery&key=$key';
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);
    var result = json['result'] as Map<String, dynamic>;
    print(result);
    return result;
  }

  Future<void> goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
    notifyListeners();
  }
}

final mapProvider = ChangeNotifierProvider<MapNotifier>((ref) => MapNotifier());
