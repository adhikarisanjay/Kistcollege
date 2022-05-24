import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:kist/Services/storageservice.dart';
import 'package:kist/modal/authuser.dart';
import 'package:kist/modal/categorymodal.dart';
import 'package:kist/modal/logniresponsemodal.dart';
import 'package:kist/modal/samplejson.dart';
import 'package:http/http.dart' as http;

class ApiConnectService {
  Future<SampleJson?> fetchSamplejson() async {
    var jsondata = await rootBundle.loadString('assets/testjsonfile/data.json');

    var list = SampleJson.fromMap(jsonDecode(jsondata));
    print(list.name);
    return list;
    // return
  }

  Future<List<SampleJson>> fetchSamplejsonArray() async {
    var jsondata =
        await rootBundle.loadString('assets/testjsonfile/arrayjson.json');
    List<dynamic> listdata = jsonDecode(jsondata);
    var list = listdata.map((e) => SampleJson.fromMap(e)).toList();
    return list;
    // return
  }

  Future<LoginModal?> callloginapi(event) async {
    print("service call");
    try {
      var response = await Dio().post('http://10.0.2.2:8000/api/login',
          data: {"email": event.email, "password": event.password});
      print(response.data);
      var returnresponse = LoginModal.fromJson(response.data);
      return returnresponse;
    } catch (e) {
      return LoginModal.withError(e.toString());
      print(e);
    }
    // try {
    //   var response = await http.post(
    //       Uri.parse('http://10.0.2.2:8000/api/login'),
    //       body: {"email": event.email, "password": event.password});
    //   print(response.body);

    // } catch (e) {
    //   print(e);
    // }
  }

  Future<LoginModal?> callloginapicubit(email, password) async {
    print("service call");
    try {
      var response = await Dio().post('http://10.0.2.2:8000/api/login',
          data: {"email": email, "password": password});
      print(response.data);
      var returnresponse = LoginModal.fromJson(response.data);
      return returnresponse;
    } catch (e) {
      return LoginModal.withError(e.toString());
      print(e);
    }
  }

  Future<AuthUser?> authUserdata() async {
    var token = await Storage().getLogintoken();
    print('token$token');
    print("service call");
    try {
      var response = await Dio().get('http://10.0.2.2:8000/api/user',
          options: Options(headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      print(response.data);
      var returnresponse = AuthUser.fromJson(response.data);
      return returnresponse;
    } catch (e) {
      print(e);
      return AuthUser.withError(e.toString());
    }
  }

  Future<List<Category>?> categoriesApi() async {
    var token = await Storage().getLogintoken();
    print('token$token');
    print("service call");
    try {
      var response = await Dio().get('http://10.0.2.2:8000/api/category',
          options: Options(headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      print(response.data);

      List<dynamic> list = response.data['data'];
      var returnresponse = list.map((e) => Category.fromJson(e)).toList();

      return returnresponse;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
