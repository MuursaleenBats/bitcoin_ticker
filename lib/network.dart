import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  Future getBitcoinData() async {
    http.Response res =
        await http.get(Uri.parse("https://blockchain.info/ticker"));
    String data = res.body;
    var bitcoinData = jsonDecode(data);
    if (res.statusCode == 200) {
      return bitcoinData;
    } else {
      print(res.statusCode);
    }
  }
}
