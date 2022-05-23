import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
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
}
