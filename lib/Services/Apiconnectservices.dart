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
}
