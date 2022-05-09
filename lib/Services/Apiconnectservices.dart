import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kist/modal/samplejson.dart';

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
}
