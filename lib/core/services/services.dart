import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:minpro_gani/core/models/detailuser_model.dart';
import 'package:minpro_gani/core/models/listofusers_model.dart';
import 'package:minpro_gani/core/models/response_new_user.dart';

class ProfileService {
  final Dio dio = Dio();

  Future fetchListofUsers() async {
    final response = await dio.get("https://reqres.in/api/users",
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));
    // ignore: avoid_print
    print(response.statusCode);
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("Fetch Users List Berhasil");
      return compute(listUsersModelFromJson, json.encode(response.data));
    }
  }

  Future fetchDetailUser(int? id) async {
    final response = await dio.get("https://reqres.in/api/users/$id",
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));
    // ignore: avoid_print
    print(response.statusCode);
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("Fetch Detail User Berhasil");
      return compute(detailUserModelFromJson, json.encode(response.data));
    }
  }

  Future addNewUser(String name, String job) async {
    final response = await dio.post(
      "https://reqres.in/api/users",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {"name": name, "job": job},
    );

    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 201) {
      // ignore: avoid_print
      print("Add User Success");
      return compute(responseNewUserFromJson, json.encode(response.data));
    }
  }
}
