import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String? url;

  NetworkHelper({this.url});

  Future<dynamic> getData() async {
    http.Response response = await http.get(
      Uri.parse(url!),
    );
    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
