import 'dart:convert';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:kist/Services/storageservice.dart';
import 'package:kist/modal/authuser.dart';
import 'package:kist/modal/categories.dart';
import 'package:kist/modal/categorymodal.dart';
import 'package:kist/modal/logniresponsemodal.dart';
import 'package:kist/modal/samplejson.dart';
import 'package:http/http.dart' as http;

class ApiConnectService {
// Global options
  final optionsdata = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),

    // All subsequent fields are optional.

    // Default.
    policy: CachePolicy.request,
    // Returns a cached response on error but for statuses 401 & 403.
    // Also allows to return a cached response on network errors (e.g. offline usage).
    // Defaults to [null].
    hitCacheOnErrorExcept: [401, 403],
    // Overrides any HTTP directive to delete entry past this duration.
    // Useful only when origin server has no cache config or custom behaviour is desired.
    // Defaults to [null].
    maxStale: const Duration(days: 7),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended when [true].
    allowPostMethod: false,
  );
  DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());

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
      final dio = Dio()
        ..interceptors.add(DioCacheInterceptor(options: optionsdata));
      var response = await dio.get('http://10.0.2.2:8000/api/category',
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

  Future<Categoriesmodal?> categoriesstoreApi(title, desc, image) async {
    var token = await Storage().getLogintoken();
    print('imagedata$image');
    print("service call");

    var imagefile = MultipartFile.fromFileSync(
      image,
      filename: image.split("/")[image.split("/").length - 1],
    );
    FormData formdata = FormData.fromMap(
        {"title": title, "description": desc, "image": imagefile});
    print(formdata);

    try {
      var response = await Dio().post('http://10.0.2.2:8000/api/category',
          data: formdata,
          options: Options(headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      print(response.data);

      return Categoriesmodal.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      return Categoriesmodal.withError(e.toString());
    }
  }
}
