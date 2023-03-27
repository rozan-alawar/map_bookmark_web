import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocode/geocode.dart';
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

  bool isLoading = false;

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

  void getAddressFromLatLong(LatLng position) async {
    GeoCode geocode = GeoCode();
    Address add = await geocode.reverseGeocoding(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    currentAddress =
        '${add.countryName ?? ''} - ${add.region ?? ''} - ${add.city ?? ''} - ${add.streetAddress ?? ''}';
    print(currentAddress);
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
          zoom: 15,
        ),
      ),
    );
    // getAddressFromLatLong(location);
    print(Geolocator.distanceBetween(31.5017, 34.4669, 32.5017, 35.4669));
    notifyListeners();
  }

  String key = 'AIzaSyB4nJ_35oFFm0vh6dBeXdncZfWc7Jouhwc';
  searchandNavigate() {
    // placemarkFromAddress(searchAddr).then((result) {
    //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //       target:
    //           LatLng(result[0].position.latitude, result[0].position.longitude),
    //       zoom: 10.0)));
    // });
  }

  Future<String> getPlaceByID(String input) async {
    print('lkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);
    final placeId = json['candidates'][0]['place_id'];
    print(placeId);
    return placeId;
  }
}

final mapProvider = ChangeNotifierProvider<MapNotifier>((ref) => MapNotifier());
