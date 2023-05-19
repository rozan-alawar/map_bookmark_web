import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal/data/api/api_constants/constants.dart';
import 'package:minimal/data/models/fav_response.dart';

import '../../models/auth_response.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "lang": "en",
      },
    ),
  );

// --------------------------------    LOGIN     -------------------------------------------------

  Future<AuthResponse> login({
    required String username,
    required String password,
  }) async {
    final response = await _dio.post(ApiConstants.loginEndpoint, data: {
      'username': username,
      'password': password,
    });

    AuthResponse loginResponse = AuthResponse.fromJson(response.data);
    return loginResponse;
  }

  // --------------------------------    REGISTER     -------------------------------------------------

  Future<AuthResponse> signup({
    required String username,
    required String email,
    required String mobile,
    required String password,
  }) async {
    final response = await _dio.post(ApiConstants.signUpEndpoint, data: {
      'username': username,
      'email': email,
      'mobile': mobile,
      'Country': "Gaza",
      'password': password,
    });

    AuthResponse authResponse = AuthResponse.fromJson(response.data);
    return authResponse;
  }

// --------------------------------    LOGIN     -------------------------------------------------

  Future<AuthResponse> userProfile() async {
    final response = await _dio.post(
      "${ApiConstants.loginEndpoint}/ ",
    );

    AuthResponse loginResponse = AuthResponse.fromJson(response.data);
    return loginResponse;
  }

// --------------------------------    FAVOURITES     -------------------------------------------------

  Future<FavoriteResponse> favorites() async {
    final response = await _dio.get(ApiConstants.favEndpoint);

    FavoriteResponse favResponse = FavoriteResponse.fromJson(response.data);
    return favResponse;
  }
}

final apiServices = Provider((ref) => ApiServices());
